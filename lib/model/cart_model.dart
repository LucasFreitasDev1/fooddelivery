import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/data/cart_product.dart';
import 'package:food_delivery_app/model/user_client_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class CartModel extends Model {
  UserClientModel user;

  List<CartProduct> products = [];

  List<String> listStores = [];

  String couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user) {
    if (user.uid != null) _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    final String titleStore = cartProduct.store;

    if (!listStores.contains(titleStore)) listStores.add(titleStore);

    Firestore.instance
        .collection("users")
        .document(user.uid)
        .collection("cart")
        .document('admins')
        .collection(cartProduct.adminId)
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.uid)
        .collection("cart")
        .document('admins')
        .collection(cartProduct.adminId)
        .document(cartProduct.cid)
        .delete();

    products.remove(cartProduct);

    bool retain = false;
    products.map((product) {
      if (cartProduct.store == product.store) retain = true;
    });

    if (!retain) listStores.remove(cartProduct.store);

    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    Firestore.instance
        .collection("users")
        .document(user.uid)
        .collection("cart")
        .document('admins')
        .collection(cartProduct.adminId)
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;

    Firestore.instance
        .collection("users")
        .document(user.uid)
        .collection("cart")
        .document('admins')
        .collection(cartProduct.adminId)
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices() {
    notifyListeners();
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct c in products) {
      if (c.productData != null) price += c.quantity * c.productData.price;
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice() {
    return 1.99;
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    List<String> admins;

    for (CartProduct cartProduct in products) {
      if (!admins.contains(cartProduct.adminId)) {
        admins.add(cartProduct.adminId);
      }
    }

    for (String adminId in admins) {
      DocumentReference refOrder =
          await Firestore.instance.collection("orders").add({
        "adminId": adminId,
        "clientId": user.uid,
        "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
        "shipPrice": shipPrice,
        "productsPrice": productsPrice,
        "discount": discount,
        "totalPrice": productsPrice - discount + shipPrice,
        "status": 1
      });

      await Firestore.instance
          .collection("users")
          .document(user.uid)
          .collection("orders")
          .document('admins')
          .collection(adminId)
          .document(refOrder.documentID)
          .setData({"orderId": refOrder.documentID});

      QuerySnapshot query = await Firestore.instance
          .collection("users")
          .document(user.uid)
          .collection("cart")
          .getDocuments();

      for (DocumentSnapshot doc in query.documents) {
        doc.reference.delete();
      }

      products.clear();

      couponCode = null;
      discountPercentage = 0;

      isLoading = false;
      notifyListeners();

      return refOrder.documentID;
    }
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.uid)
        .collection("cart")
        .getDocuments();

    QuerySnapshot query2;

    for (DocumentSnapshot doc in query.documents) {
      query2 = await Firestore.instance
          .collection("users")
          .document(user.uid)
          .collection("cart")
          .document('admins')
          .collection(doc.documentID)
          .getDocuments();
      query.documents.addAll(query2.documents);
    }

    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }
}

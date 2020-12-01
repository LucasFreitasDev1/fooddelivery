import 'dart:async';
import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/blocs/login_bloc.dart';
import 'package:food_delivery_app/data/cart_product.dart';
import 'package:food_delivery_app/model/user_client_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class CartModel extends Model {
  UserClientModel user;

  Map<String, List<CartProduct>> products = Map<String, List<CartProduct>>();

  String couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user) {
    if (user.uid != null) _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    log('CARTPRODUCT: ' + cartProduct.toMap().toString());
    log('PRODUCTS: ' + products.toString());
    products.addAll({
      cartProduct.adminId: [cartProduct]
    });
    //products[cartProduct.adminId].add(cartProduct);
    // products.add(cartProduct);
    // final String titleStore = cartProduct.store;

    // if (!listStores.contains(titleStore)) listStores.add(titleStore);

    Firestore.instance
        .collection("users")
        .document(user.uid)
        .collection("cart")
        .document(cartProduct.adminId)
        .collection('products')
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
        .document(cartProduct.adminId)
        .collection('products')
        .document(cartProduct.cid)
        .delete();

    products[cartProduct.adminId].remove(cartProduct);

    /*  bool retain = false;
    products.map((product) {
      if (cartProduct.store == product.store) retain = true;
    });

    if (!retain) listStores.remove(cartProduct.store);
 */
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    Firestore.instance
        .collection("users")
        .document(user.uid)
        .collection("cart")
        .document(cartProduct.adminId)
        .collection('products')
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
        .document(cartProduct.adminId)
        .collection('products')
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

  double getProductsPriceTotal() {
    double priceTotal = 0.0;
    for (String adminId in products.keys) {
      double priceAdmin = getProductsPriceAdmin(adminId);
      priceAdmin += getShipPrice(adminId);
      priceAdmin -= getDiscount(adminId);
      priceTotal += priceAdmin;
    }
    return priceTotal;
  }

  double getProductsPriceAdmin(String adminId) {
    double price = 0.0;
    for (CartProduct c in products[adminId]) {
      if (c.productData != null) price += c.quantity * c.productData.price;
    }
    return price;
  }

  double getDiscount(String adminId) {
    return getProductsPriceAdmin(adminId) * discountPercentage / 100;
  }

  double getShipPrice(String adminId) {
    /* Firestore.instance
        .collection('admins')
        .document(adminId)
        .collection('shipPrice')
        .document('1')
        .get()
        .then((doc) {
      if (doc.data['price'] != null) {
        return doc.data['price'] as double;
      }
    }); */
    return 1.99;
  }

  // ignore: missing_return
  Future<String> finishOrder() async {
    if (products.length == 0) return null;

    isLoading = true;
    notifyListeners();

/* 
    List<String> admins;

    for (CartProduct cartProduct in products) {
      if (!admins.contains(cartProduct.adminId)) {
        admins.add(cartProduct.adminId);
      }
    } */

    for (String adminId in products.keys) {
      double productsPrice = getProductsPriceTotal();
      double shipPrice = getShipPrice(adminId);
      double discount = getDiscount(adminId);

      DocumentReference refOrder = await Firestore.instance
          .collection("orders")
          .document(adminId)
          .collection(user.uid)
          .add({
        "adminId": adminId,
        "clientId": user.uid,
        "products": products[adminId]
            .map((cartProduct) => cartProduct.toMap())
            .toList(),
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

  Future<void> _loadCartItems() async {
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
          .document(doc.documentID)
          .collection('products')
          .getDocuments();
      /* 
      products.addAll({
        doc.documentID: query2.documents
            .map((doc) => CartProduct.fromDocument(doc))
            .toList()
      }); */

      products[doc.documentID] =
          query2.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
    }

    /*   products[adminId] =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
 */
    notifyListeners();
  }
}

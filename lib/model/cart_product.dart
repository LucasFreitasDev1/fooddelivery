import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/model/productData.dart';

class CartProduct {
  String cid;

  String category;
  String pid;
  String adminId;

  int quantity;
  String store;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    adminId = document.data['adminId'];
    quantity = document.data["quantity"];
    store = document.data["store"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      'adminId': adminId,
      "quantity": quantity,
      "store": store,
      "product": productData.toResumedMap()
    };
  }
}

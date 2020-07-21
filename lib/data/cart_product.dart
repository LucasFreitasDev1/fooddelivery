import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/data/productData.dart';

class CartProduct {
  String cid;

  String category;
  String pid;

  int quantity;
  String empresa;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantity = document.data["quantity"];
    empresa = document.data["empresa"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "empresa": empresa,
      "product": productData.toResumedMap()
    };
  }
}

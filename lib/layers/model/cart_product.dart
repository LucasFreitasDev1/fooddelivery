import 'package:cloud_firestore/cloud_firestore.dart';

import 'product_model.dart';

class CartProduct {
  String? cid;

  String? category;
  String? pid;
  String? adminId;

  int? quantity;
  String? store;

  ProductModel? productData;

  CartProduct.fromDocument(DocumentSnapshot doc) {
    cid = doc.id;
    category = doc["category"];
    pid = doc["pid"];
    adminId = doc['adminId'];
    quantity = doc["quantity"];
    store = doc["store"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      'adminId': adminId,
      "quantity": quantity,
      "store": store,
      "product": productData?.toResumedMap()
    };
  }
}

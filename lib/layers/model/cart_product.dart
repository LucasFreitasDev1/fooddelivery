import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'product_model.dart';

class CartProduct {
  String cid;

  String category;
  String pid;
  String adminId;

  int quantity;
  String store;

  ProductModel productData;
  CartProduct({
    required this.cid,
    required this.category,
    required this.pid,
    required this.adminId,
    required this.quantity,
    required this.store,
    required this.productData,
  });

  Map<String, dynamic> toMap() {
    return {
      'cid': cid,
      'category': category,
      'pid': pid,
      'adminId': adminId,
      'quantity': quantity,
      'store': store,
      'productData': productData.toMap(),
    };
  }

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      cid: map['cid'] ?? '',
      category: map['category'] ?? '',
      pid: map['pid'] ?? '',
      adminId: map['adminId'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      store: map['store'] ?? '',
      productData: ProductModel.fromMap(map['productData']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProduct.fromJson(String source) =>
      CartProduct.fromMap(json.decode(source));
}

import 'dart:convert';

import 'store_model.dart';

class ProductModel {
  String id;
  StoreModel store;
  String storeId;
  String title;
  double price;
  List images;
  String storeName;
  String category;
  String description;
  DateTime dateCreate;
  ProductModel({
    required this.id,
    required this.store,
    required this.storeId,
    required this.title,
    required this.price,
    required this.images,
    required this.storeName,
    required this.category,
    required this.description,
    required this.dateCreate,
  });

  Map<String, dynamic> toResumedMap() {
    return {"title": title, "price": price, 'store': storeName};
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'store': store.toMap(),
      'storeId': storeId,
      'title': title,
      'price': price,
      'images': images,
      'storeName': storeName,
      'category': category,
      'description': description,
      'dateCreate': dateCreate.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      store: StoreModel.fromMap(map['store']),
      storeId: map['storeId'] ?? '',
      title: map['title'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      images: List.from(map['images']),
      storeName: map['storeName'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      dateCreate: DateTime.fromMillisecondsSinceEpoch(map['dateCreate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}

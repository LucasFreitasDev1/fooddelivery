import 'package:food_delivery_app/model/store_model.dart';

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
}

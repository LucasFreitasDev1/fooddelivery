import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;
  String adminId;
  String title;
  String price;
  List images;
  String store;
  String category;
  String description;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.adminId = snapshot.data['adminId'];
    this.title = snapshot.data['title'];
    this.price = snapshot.data['price'];
    this.images = snapshot.data['images'];
    this.store = snapshot.data['store'];
    this.category = snapshot.data['category'];
    this.description = snapshot.data['description'];
  }

  Map<String, dynamic> toResumedMap() {
    return {"title": title, "price": price, 'store': store};
  }
}

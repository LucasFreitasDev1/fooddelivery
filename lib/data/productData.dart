import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;
  String title;
  double price;
  String imgUrl;
  String empresa;
  String category;
  String description;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    this.id = snapshot.documentID;
    this.title = snapshot.data['title'];
    this.price = snapshot.data['price'];
    this.imgUrl = snapshot.data['imgUrl'];
    this.empresa = snapshot.data['empresa'];
    this.category = snapshot.data['category'];
    this.description = snapshot.data['description'];
  }

  Map<String, dynamic> toResumedMap() {
    return {"title": title, "description": description, "price": price};
  }
}

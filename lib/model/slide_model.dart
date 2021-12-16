import 'package:cloud_firestore/cloud_firestore.dart';

class SlideModel {
  String id;
  String orderId;
  String imageFit;
  String food;
  String store;
  bool enabled;

  SlideModel();

  SlideModel.fromDocument(DocumentSnapshot snapshot) {
    try {
      this.id = snapshot.documentID;
      this.store = snapshot.data['store'] ?? '';
      this.imageFit = snapshot.data['imageFit'] ?? '';
      this.food = snapshot.data['food'] ?? '';
      this.enabled = snapshot.data['enabled'] ?? false;
      this.orderId = snapshot.data['orderId'] ?? '';
    } on Exception catch (e) {
      throw 'No found';
    }
  }
}

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
      this.store = snapshot.data['storeId'] ?? '';
      this.imageFit = snapshot.data['imageFit'] ?? '';
      this.food = snapshot.data['foodId'] ?? '';
      this.enabled = snapshot.data['enabled'] ?? false;
      this.orderId = snapshot.data['orderId'] ?? '';
    } on Exception catch (_) {
      throw 'No found';
    }
  }
}

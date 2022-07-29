import 'package:cloud_firestore/cloud_firestore.dart';

class SlideModel {
  String id;
  String orderId;
  String imageFit;
  String foodId;
  String storeId;
  bool enabled;

  SlideModel(
      {required this.id,
      required this.enabled,
      required this.foodId,
      required this.imageFit,
      required this.orderId,
      required this.storeId});

  static SlideModel fromDocument(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return SlideModel(
        id: snapshot.id,
        enabled: snapshot.data()?['enabled'] ?? false,
        foodId: snapshot.data()?['foodId'].toString() ?? '',
        imageFit: snapshot.data()?['imageFit'].toString() ?? '',
        orderId: snapshot.data()?['orderId'].toString() ?? '',
        storeId: snapshot.data()?['storeId'].toString() ?? '');
  }
}

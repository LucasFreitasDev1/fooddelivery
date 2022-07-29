import 'dart:convert';

class SlideModel {
  String id;
  String? orderId;
  String imageFit;
  String? foodId;
  String? storeId;
  bool enabled;

  SlideModel({
    required this.id,
    this.orderId,
    required this.imageFit,
    this.foodId,
    this.storeId,
    required this.enabled,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'imageFit': imageFit,
      'foodId': foodId,
      'storeId': storeId,
      'enabled': enabled,
    };
  }

  factory SlideModel.fromMap(Map<String, dynamic> map) {
    return SlideModel(
      id: map['id'] ?? '',
      orderId: map['orderId'] ?? '',
      imageFit: map['imageFit'] ?? '',
      foodId: map['foodId'] ?? '',
      storeId: map['storeId'] ?? '',
      enabled: map['enabled'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SlideModel.fromJson(String source) =>
      SlideModel.fromMap(json.decode(source));

  SlideModel copyWith({
    String? id,
    String? orderId,
    String? imageFit,
    String? foodId,
    String? storeId,
    bool? enabled,
  }) {
    return SlideModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      imageFit: imageFit ?? this.imageFit,
      foodId: foodId ?? this.foodId,
      storeId: storeId ?? this.storeId,
      enabled: enabled ?? this.enabled,
    );
  }
}

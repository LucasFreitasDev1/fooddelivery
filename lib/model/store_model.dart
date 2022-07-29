import 'dart:convert';

import 'package:food_delivery_app/model/address_model.dart';

class StoreModel {
  String id;
  String title;
  String nameSocio;
  String phone;
  String email;
  String? imgPerfil;
  String? imgBack;
  AddressModel address;
  StoreModel({
    required this.id,
    required this.title,
    required this.nameSocio,
    required this.phone,
    required this.email,
    required this.imgPerfil,
    required this.imgBack,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'nameSocio': nameSocio,
      'phone': phone,
      'email': email,
      'imgPerfil': imgPerfil,
      'imgBack': imgBack,
      'address': address.toMap(),
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      nameSocio: map['nameSocio'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      imgPerfil: map['imgPerfil'],
      imgBack: map['imgBack'],
      address: AddressModel.fromMap(map['address']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) =>
      StoreModel.fromMap(json.decode(source));
}

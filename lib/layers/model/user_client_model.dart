import 'dart:convert';

import 'address_model.dart';

class UserClient {
  String? phone;
  String? name;
  String? email;
  String? password;
  String? uid;
  AddressModel? address;
  DateTime? registeredDate;
  String? cpf;
  Map<String, dynamic>? tokenOtp;

  UserClient(
      {this.phone,
      this.name,
      this.email,
      this.password,
      this.uid,
      this.address,
      this.registeredDate,
      this.cpf,
      this.tokenOtp});

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'name': name,
      'email': email,
      'senha': password,
      'uid': uid,
      'address': address?.toMap(),
      'registeredDate': registeredDate?.millisecondsSinceEpoch,
      'cpf': cpf,
      'tokenOtp': tokenOtp,
    };
  }

  factory UserClient.fromMap(Map<String, dynamic> map) {
    return UserClient(
      phone: map['phone'],
      name: map['name'],
      email: map['email'],
      password: map['senha'],
      uid: map['uid'],
      address:
          map['address'] != null ? AddressModel.fromMap(map['address']) : null,
      registeredDate: map['registeredDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['registeredDate'])
          : null,
      cpf: map['cpf'],
      tokenOtp: Map<String, dynamic>.from(map['tokenOtp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserClient.fromJson(String source) =>
      UserClient.fromMap(json.decode(source));
}

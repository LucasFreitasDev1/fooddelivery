import 'package:food_delivery_app/model/address_model.dart';

class UserClient {
  String? phone;
  String? name;
  String? email;
  String? senha;
  String? uid;
  AddressModel? address;
  DateTime? registeredDate;
  String? cpf;
  Map<String, dynamic>? tokenOtp;

  UserClient(
      {this.phone,
      this.name,
      this.email,
      this.senha,
      this.uid,
      this.address,
      this.registeredDate,
      this.cpf,
      this.tokenOtp});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'name': name,
      'email': email,
      'address': address
    };
  }
}

class UserClientModel {
  String phone;
  String name;
  String email;
  String uid;
  Map address = {
    'cidade': '',
    'bairro': '',
    'estado': '',
    'complemento': '',
    'referencia': '',
    'rua': '',
  };

  UserClientModel({this.phone, this.email, this.name, this.uid, this.address});

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

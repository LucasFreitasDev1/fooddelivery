import 'dart:convert';

class AddressModel {
  String rua;
  String bairro;
  String numero;
  String cep;
  String cidade;
  String estado;
  String complemento;
  String pontoRef;
  AddressModel({
    required this.rua,
    required this.bairro,
    required this.numero,
    required this.cep,
    required this.cidade,
    required this.estado,
    required this.complemento,
    required this.pontoRef,
  });

  Map<String, dynamic> toMap() {
    return {
      'rua': rua,
      'bairro': bairro,
      'numero': numero,
      'cep': cep,
      'cidade': cidade,
      'estado': estado,
      'complemento': complemento,
      'pontoRef': pontoRef,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      rua: map['rua'] ?? '',
      bairro: map['bairro'] ?? '',
      numero: map['numero'] ?? '',
      cep: map['cep'] ?? '',
      cidade: map['cidade'] ?? '',
      estado: map['estado'] ?? '',
      complemento: map['complemento'] ?? '',
      pontoRef: map['pontoRef'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));
}

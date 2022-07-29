import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'validators/address_validators.dart';

class AddressBloc extends BlocBase with AddressValidators {
  /*  void dispose() {
    _ruaController.close();
    _bairroController.close();
    _cidadeController.close();
    _estadoController.close();
    _complementoController.close();
    _referenciaController.close();
  } */
  @override
  void dispose() {
    _loadingController.close();
    _ruaController.close();
    _bairroController.close();
    _cidadeController.close();
    _estadoController.close();
    _complementoController.close();
    _referenciaController.close();
    super.dispose();
  }

  final _ruaController = StreamController<String>();
  final _bairroController = StreamController<String>();
  final _cidadeController = StreamController<String>();
  final _estadoController = StreamController<String>();
  final _complementoController = StreamController<String>();
  final _referenciaController = StreamController<String>();
  final _loadingController = StreamController<bool>();

  Function(String) get changeRua => _ruaController.sink.add;
  Function(String) get changeBairro => _bairroController.sink.add;
  Function(String) get changeCidade => _cidadeController.sink.add;
  Function(String) get changeEstado => _estadoController.sink.add;
  Function(String) get changeComplemento => _complementoController.sink.add;
  Function(String) get changeReferencia => _referenciaController.sink.add;

  Stream<bool> get outLoading => _loadingController.stream;
  Stream<String> get outRua => _ruaController.stream.transform(validateRua);
  Stream<String> get outBairro =>
      _bairroController.stream.transform(validateBairro);
  Stream<String> get outCidade =>
      _cidadeController.stream.transform(validateCidade);
  Stream<String> get outEstado =>
      _estadoController.stream.transform(validateEstado);
  Stream<String> get outComplemento => _complementoController.stream;
  Stream<String> get outReferencia =>
      _referenciaController.stream.transform(validateReferencia);

  ///
  /// Functions
  ///
  Future<String> saveAddress() async {
    String message = '';
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if (user == null) {
      message = 'Usuario não conectado';
      return message;
    }

    Map<String, dynamic> address = {
      'cidade': _cidadeController.stream.first,
      'bairro': _bairroController.stream.first,
      'estado': _estadoController.stream.first,
      'complemento': _complementoController.stream.first,
      'referencia': _referenciaController.stream.first,
      'rua': _ruaController.stream.first,
    };

    await Firestore.instance
        .collection('users')
        .document(user.uid)
        .updateData({'address': address}).catchError((error) {
      message = 'Ocorreu um erro. Tente novamente!';
    });

    return message;
  }
}

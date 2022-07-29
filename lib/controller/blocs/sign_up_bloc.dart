import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/model/user_client_model.dart';

import 'validators/login_validators.dart';
import 'validators/signup_validator.dart';

class SignUpBloc extends BlocBase with SignUpValidator, LoginValidators {
  final _emailController = StreamController<String>();
  final _passwordController = StreamController<String>();
  final _confirmPassController = StreamController<String>();
  final _nameController = StreamController<String>();
  final _titleStoreController = StreamController<String>();
  final _phoneController = StreamController<String>();
  final _loadingController = StreamController<bool>();

  UserClient? userModel;

  // ignore: unused_field
  // FirebaseUser _firebaseUser;

  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword =>
      _passwordController.stream.transform(validatePassword);
  Future<Stream<String>> get outConfirmPass async =>
      _confirmPassController.stream.transform(validateConfirmPassword(
          await _passwordController.stream.first));
  Stream<String> get outName => _nameController.stream.transform(validateName);
  Stream<String> get outTitleStore =>
      _titleStoreController.stream.transform(validateNameStore);
  Stream<String> get outPhone =>
      _phoneController.stream.transform(validatePhone);
  Stream<bool> get outLoading => _loadingController.stream;

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeTitleStore => _titleStoreController.sink.add;

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _confirmPassController.close();
    _nameController.close();
    _phoneController.close();
    _loadingController.close();
    _titleStoreController.close();
    super.dispose();
  }
/* 
  Future<String> signUp() async {
    _loadingController.add(true);
    userModel = UserClientModel(
        email: _emailController.stream.first,
        name: _nameController.stream.first,
        phone: _phoneController.stream.first,
        address: {});
    String password = _passwordController.stream.first;
    String message = ''; */

    /// Verifica se não está nulo
   /*  if (userModel.email == null || userModel.email.isEmpty) {
      message = 'Preencha os campos corretamente';
      _loadingController.add(false);
      return message;
    } else {
      ///Cria usuario
      message = await _createUser(userModel.email, password);
      _loadingController.add(false);
      return message;
    } */
  }

  /// Function for save data on Firebase
  Future<void> _saveDataonFirestore() async {
    await Firestore.instance
        .collection('users')
        .document(userModel.uid)
        .setData(userModel.toMap());
  }

  /// Function for create user on Firebase and Firestore with email and pass
  Future<String> _createUser(String email, String password) async {
    String messageError = '';
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser) async {
      userModel.uid = firebaseUser.uid;
      _firebaseUser = firebaseUser;
      await _saveDataonFirestore();
    }).catchError((error) async {
      switch (error.code) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          messageError = 'Email já cadastrado. Faça login.';
          break;
        case 'ERROR_INVALID_EMAIL':
          messageError = 'Formato de email invalido';
          break;
        default:
          messageError = 'Ocorreu um erro. Tente novamente.';
      }
    });
    return messageError;
  }
}

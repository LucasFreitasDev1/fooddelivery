import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/model/user_client_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'validators/login_validators.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword =>
      _passwordController.stream.transform(validatePassword);
  Stream<LoginState> get outState => _stateController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(outEmail, outPassword, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  StreamSubscription _streamSubscription;

  UserClientModel userModel;

  LoginBloc() {
    userModel = UserClientModel();

    try {
      _streamSubscription =
          FirebaseAuth.instance.onAuthStateChanged.listen((user) async {
        if (user != null) {
          await Firestore.instance
              .collection('users')
              .document(user.uid)
              .get()
              .then((doc) {
            userModel.name = doc.data['name'];
            userModel.phone = doc.data['phone'];
            userModel.email = doc.data['email'];
            userModel.uid = user.uid;
            userModel.address = doc.data['address'];
          });
          _stateController.add(LoginState.SUCCESS);
        } else {
          _stateController.add(LoginState.IDLE);
        }
      });
    } on Exception catch (_) {
      _stateController.add(LoginState.FAIL);
    }
  }

  Future<String> submit() async {
    final email = _emailController.value;
    final password = _passwordController.value;
    String message = '';

    _stateController.add(LoginState.LOADING);
    _loadingController.add(true);

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _stateController.add(LoginState.SUCCESS);
    }).catchError((e) {
      _stateController.add(LoginState.FAIL);
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          message = 'Email inválido.';
          break;
        case 'ERROR_WRONG_PASSWORD':
          message = 'Senha incorreta.';
          break;
        case 'ERROR_USER_NOT_FOUND':
          message = 'Usuario não cadastrado.';
          break;
        case 'ERROR_USER_DISABLED':
          message = 'Usuario desabilitado.';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          message =
              'Foram feitas muitas tentativas. Aguarde alguns instantes e tente novamente.';
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          message = 'Verique os campos e tente novamente.';
          break;
        default:
          message = 'Algo deu errado. Tente novmente.';
      }
    });
    _loadingController.add(false);
    return message;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    userModel = UserClientModel();
    _stateController.add(LoginState.FAIL);
  }

  Future<String> recoveryPassword() async {
    final email = _emailController.value;
    if (email == null || !email.contains('@')) {
      return 'Digite um email válido';
    }
    String error;
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .catchError((e) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          error = 'Email invalido';
          break;
        case 'ERROR_USER_NOT_FOUND':
          error = 'Email não cadastrado ou incorreto';
          break;
        default:
          error =
              'Ocorreu um erro. Verique se o email está correto e tente novamente';
      }
    });
    return error;
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
    _loadingController.close();

    _streamSubscription.cancel();
  }
}

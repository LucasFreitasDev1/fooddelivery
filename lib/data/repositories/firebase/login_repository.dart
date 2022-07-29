import 'package:food_delivery_app/model/user_client_model.dart';

import '../../datasources/firebase.dart';

class LoginRepositoryImpl {
  final FirebaseDatasource _firebase;

  LoginRepositoryImpl(
    this._firebase,
  );

  ///Faz login usando email e senha
  ///Caso seja sucesso retorna String vazia
  ///Caso dê algum erro retorna String com messagem de erro tratada
  loginWithEmailAndPassowrd(String email, String password) async {
    if (!validateEmail(email)) {
      return 'Email inválido';
    }
    if (!validatePassword(password)) {
      return 'Senha inválida';
    }

    var resultError =
        await _firebase.loginWithEmailAndPassword(email, password);

    if (resultError.isEmpty) {
      //case success
      return '';
    } else {
      //case error
      return resultError;
    }
  }

  Future<String> recoveryPassword(String email) async {
    if (!email.contains('@') && !email.contains('.com')) {
      return 'Email Inválido';
    }

    var resultError = await _firebase.recoverPasswordWithEmail(email);
    if (resultError.isEmpty) {
      //case success
      return 'Instruções para recuperação de senha enviado para o email informado';
    } else {
      //case error
      return resultError;
    }
  }

  bool validateEmail(String email) =>
      email.contains('@') && email.contains('.com');

  bool validatePassword(String password) =>
      password.length > 7 && password.isNotEmpty;

  Future<UserClient?> get getUserData async => await _firebase.getUserData();

  signOut() => _firebase.signOut();

/* 
  Future<VerificationStateOTP?> verifyNumberPhoneOTP(String phoneNumber) =>
      _firebase.authOTP(phoneNumber);

  Future<VerificationStateOTP> codeSentOTPVerification(String code) =>
      _firebase.codeSentOTPVerification(code);
 */

}

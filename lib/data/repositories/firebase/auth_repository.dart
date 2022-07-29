import 'dart:developer';
import 'package:food_delivery_app/model/user_client_model.dart';
import '../../datasources/firebase.dart';

class AuthRepository {
  final FirebaseDatasource _firebase;

  AuthRepository(this._firebase);

  bool isOtpState = false;

  Future<UserClient?> getCurrentUser() async {
    try {
      var user = await _firebase.getUserData();
      return user;
    } catch (e) {
      log('Erro ao obter usuario atual');
      return null;
    }
  }

  // bool getOtpStateWeb() => isOtpState;

  // _firebase.isOtpStateLogin();

}

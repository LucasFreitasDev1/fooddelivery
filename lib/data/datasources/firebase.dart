import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/model/address_model.dart';
import 'package:food_delivery_app/model/button_category_model.dart';
import 'package:food_delivery_app/model/product_model.dart';
import 'package:food_delivery_app/model/slide_model.dart';
import 'package:food_delivery_app/model/store_model.dart';
import 'package:food_delivery_app/model/user_client_model.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/button_category.dart';
import 'package:food_delivery_app/view/tiles/product_tile.dart';

class FirebaseDatasource {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  String? verificationID;
  User? user;
  String? clientDocId;

  FirebaseDatasource() {
    user = _auth.currentUser;
  }

  ///Retorna Stream com estado de autenticação do usuário
  Stream<User?> get authStateStream {
    var user = _auth.authStateChanges();
    return user;
  }

  /// Verifica se precisa verificar numero de telefone
  /// o tempo de expiração da autenticação é de 15 min
  bool isOtpStateLogin(Map<String, dynamic> map) {
    if (map['expire'] != null) {
      // se o tempo de expiração for maior que o tempo autal, ou seja, não expirou ainda
      // não precisa verificar telefone de novo
      if ((map['expire'] as Timestamp).compareTo(Timestamp.now()) > 0) {
        return false;
      }
    }
    return true;
  }

  ///Busca os dados do usuario carregados se houver
  Future<UserClient?> getUserData({String? uid}) async {
    ///  print('caregando usuario ....');
    user = await _auth.userChanges().first;
    var doc = await _db.collection('users').doc(uid ?? user?.uid).get();

    if (doc.exists) {
      try {
        return UserClient(
            uid: user?.uid,
            cpf: doc['cpf'] ?? '',
            name: doc['name'] ?? '',
            email: user?.email,
            registeredDate: (doc['registerDate'] as Timestamp).toDate(),
            phone: doc['phone'] ?? '',
            tokenOtp: doc['tokenOtp'] ?? {});
      } catch (error) {
        return null;
      }
    }
    return null;
  }

  ///Faz login do usuario no firebase com email e senha
  ///Caso seja sucesso retorna uma String vazia
  ///Caso dê algum erro retorna uma mensagem de erro
  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    String message = '';

    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      user = value.user;
      //  await loadUserData(value.user!.uid);
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          message = 'Email inválido.';
          break;
        case 'wrong-password':
          message = 'Senha incorreta.';
          break;
        case 'user-not-found':
          message = 'Usuario não encontrado.';
          break;
        case 'user-disabled':
          message = 'Usuario desativado.';
          break;
        default:
          message = 'Ocorreu um erro.';
      }
    });
    return message;
  }

  ///Recupera a senha do usuario no firebase com email
  ///Caso seja sucesso retorna uma String vazia
  ///Caso dê algum erro retorna uma mensagem de erro
  Future<String> recoverPasswordWithEmail(String email) async {
    String error = '';

    await _auth.sendPasswordResetEmail(email: email).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          error = 'Email invalido';
          break;
        case 'user-not-found':
          error = 'Email não cadastrado ou incorreto';
          break;
        default:
          error = 'Ocorreu um erro, tente novamente';
      }
    });

    return error;
  }

  ///
  /// altera a senha do usuario atual por uma nova
  /// se usuario estiver autenticado
  Future<String> changePassword(String newPassword) async {
    if (_auth.currentUser == null) {
      log('Erro ao atualizar senha. Tente novamente mais tarde. '
          'Usuario não autenticado');

      return 'Erro ao atualizar senha. Tente novamente mais tarde';
    }
    await _auth.currentUser?.updatePassword(newPassword);
    return '';
  }

  signOut() {
    user = null;
    return _auth.signOut();
  }

  /// Verifica o numero de telefone informado
  /// enviando um código de verificação para o mesmo
  /// e salva o verificationId gerado em variável, e atualiza
  ///  o status do otp para enviado, caso sucesso.
  /* 
  Future<VerificationStateOTP?> authOTP(String phoneNumber) async {
    String message = '';
    VerificationStateOTP? verificationState;
/* 
    // ignore: prefer_function_declarations_over_variables
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      _auth.currentUser!.linkWithCredential(AuthCredential(
          providerId: phoneAuthCredential.providerId,
          signInMethod: phoneAuthCredential.signInMethod));
      message = "Verification completed";
      verificationState = VerificationStateOTP.success;
    };
    // ignore: prefer_function_declarations_over_variables
    PhoneVerificationFailed verificationFailed = (FirebaseException e) {
      message = e.toString();
      verificationState = VerificationStateOTP.failed;
    };
    // ignore: prefer_function_declarations_over_variables
    PhoneCodeSent codeSent =
        (String? verificationID, [int? forceResendingToken]) {
      this.verificationID = verificationID;
      message = "Verifique a mensagem enviada para o seu numero";

      verificationState = VerificationStateOTP.sent;
      //  setData(verificationID);
    };
    // ignore: prefer_function_declarations_over_variables
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String? verifiticationID) {
      message = "Tempo expirado";
      verificationState = VerificationStateOTP.expired;
    };
    
    
      verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout); */
    try {
      await _auth
          .signInWithPhoneNumber(phoneNumber,
              RecaptchaVerifier(size: RecaptchaVerifierSize.compact))
          .then((value) {
        verificationState = VerificationStateOTP.sent;
        message = 'Codigo enviado com sucesso!';
        return verificationID = value.verificationId;
      }).catchError((e) async {
        verificationState = VerificationStateOTP.failed;
        return message =
            'Erro ao enviar codigo de verificação (FirebaseDatasource: ${e.toString()})';
      });
    } catch (er) {
      verificationState = VerificationStateOTP.failed;
      message = er.toString();
    }
    log(message);

    return verificationState;
  }

  /// Verifica se o código informado corresponde ao mesmo que foi enviado para
  ///  o numero informado anteriormente. Se sucesso, retorna um status de otp
  /// de sucesso, e linka o numero de telefone com a conta atual.
  Future<VerificationStateOTP> codeSentOTPVerification(String smsCode) async {
    var state = VerificationStateOTP.sent;

    PhoneAuthCredential phoneCredential;
    phoneCredential = PhoneAuthProvider.credential(
        verificationId: verificationID!, smsCode: smsCode);

    try {
      await _auth.currentUser?.linkWithCredential(phoneCredential);
      savephoneData(phoneCredential);
      log('FirebaseDatasource: Codigo verificado com sucesso!');
      state = VerificationStateOTP.success;
    } on FirebaseAuthException catch (e) {
      log('FirebaseDatasource erro: Numero de telefone já veririfcado: ' +
          e.code);
      if (e.code == 'provider-already-linked') {
        await _auth.currentUser
            ?.updatePhoneNumber(phoneCredential)
            .then((value) {
          savephoneData(phoneCredential);
          state = VerificationStateOTP.success;
        }).catchError((e) {
          state = VerificationStateOTP.failed;
        });
      } else {
        state = VerificationStateOTP.failed;
      }
    }
    return state;
  }

  /// Salva token de verificação de celular na web no bd com tempo de
  /// expiração de 50 min
  savephoneData(PhoneAuthCredential phoneCredential) async {
    // user = _auth.currentUser;
    log('phoneUser update: ' + user!.phoneNumber!);
    // Salva o numero de telefone e dados do novo token de verificação no db
    // sobrescrevendo dados anteriores
    await _db.collection('clientes').doc(clientDocId).update({
      'phone': user?.phoneNumber,
      'tokenOtpWeb': {
        'token': phoneCredential.token,
        'verificationId': phoneCredential.verificationId,
        'date': Timestamp.now(),
        'expire':
            Timestamp.fromDate(DateTime.now().add(const Duration(minutes: 50))),
      }
    });
    /*    .get().then((value) async {
      value.data()?.addAll({
        'phone': user?.phoneNumber,
        'tokensOtpWeb': {
          'token': phoneCredential.token,
          'verificationId': phoneCredential.verificationId,
          'date': Timestamp.now(),
          'expire': Timestamp.fromDate(
              DateTime.now().add(const Duration(minutes: 15))),
        }
      });

      await _db.collection('usuarios').doc(user?.uid).set(value.data()!);
 */
  }

  /// Busca historico de transações do usuário no db firestore
  Future<List<Map<String, dynamic>>> getTransations(String cpfCnpj) async {
    user = await _auth.userChanges().first;
    String uid = user!.uid;
    await _bs2.getHistoricRecebimentos(cpfCnpj).then((value) async {
      if (value[0].keys.first != 'erro') {
        final query = await _db
            .collection('transacoes')
            .where('favorecidoUid', isEqualTo: uid)
            .orderBy('data', descending: true)
            .get();

        List<Map<String, dynamic>> list = [];
        for (var e in query.docs) {
          (e.exists && e.data().isNotEmpty) ? list.add(e.data()) : null;
          //      print(e.data());
        }
        return list;
      } else {
        return [{}];
      }
    }).catchError((e) {
      return [{}];
    });

    return [{}];

    //  print('LIST ' + list.toString());
  }

//Busca os dados do cartão no firestore
  Future<Map<String, dynamic>> getDadosCartao(String numCartao) async {
    final doc = await _db
        .collection('cartoes')
        .where('numCartao', isEqualTo: numCartao)
        .get()
        .then((value) {
      //    log(value.docs.map((e) => e.data()).toList().toString());
      return value.docs.first.data();
    });

    if (doc['numCartao'] == numCartao) {
      return doc;
    } else {
      return {};
    }
  }

  Future<String> saveDataTransationCreditCard(CreditCardSaleModel model) async {
    user = await _auth.userChanges().first;

    var message = '';
    //porcentagem da taxa do plugpix sobre a transação
    /*  var valorDescontoTaxa =
        model.valorTotal * (model.taxaPorcentagemPlugPix / 100); */

    await _db.collection('transacoes').add({
      'clienteUid': user!.uid,
      'clienteCpfCnpj': model.clienteCpfCnpj,
      'cdLojaCliente': model.cdLoja,
      'valorCashbackCliente': 0.0,
      "recebimentoId": '',
      "txId": '',
      'data': Timestamp.now(),
      'tipo': 'Cartão de Crédito',
      'parcelas': model.parcelas,
      'valorTotal': model.valorTotalTransacao,
      'taxaPorcent': model.taxaPorcentagemPlugPix,
      'valorDescontoTaxa': model.valorDescontoTaxaReais,
      'valorFinalFloat': model.valorFinalReceptor,
      'valorParcelasFloat': model.valorParcelas,
      "status": 'Aprovada',
      'descricao': model.descricao,
      "pagador": {
        "ispb": "string",
        "conta": {},
        "pessoa": {
          "documento": model.pagadorCpfCnpj,
          "tipoDocumento": "CPF",
          "nome": model.pagadorNome,
          "nomeFantasia": "string",
          'valorCashback':
              model.valorTotalTransacao * (model.cashbackPagador ?? 0),
          "conta": "conta"
        },
      },
    }).then((value) async {
      await _db
          .collection('usuarios')
          .doc(user!.uid)
          .collection('transacoes')
          .doc(value.id)
          .set({
        'tipo': 'Cartão de Crédito',
        'id': value.id,
      }).catchError((e) {
        message = 'Erro: ' + e.toString();
      });
    }).catchError((e) {
      message = 'Erro: ' + e.toString();
    });

    return message;
  } */

  Future<List<CategoryButtonModel>?>? getCategoriesButtons() async {
    try {
      var query = await _db.collection('category').get();

      if (query.docs.isNotEmpty) {
        return query.docs
            .map((e) => CategoryButtonModel(id: e.id, img: e.data()['img']))
            .toList();
      } else {
        log('erro ao buscar dados do produto');
        return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<ProductModel?>?> getProdutcsCategories(String category) async {
    try {
      var query = await _db
          .collection('products')
          .where('category', isEqualTo: category)
          .get();

      if (query.docs.isNotEmpty) {
        return query.docs.map((e) {
          if (e.exists) {
            return ProductModel(
                id: e.id,
                storeId:
                    (e.data()['storeId'] ?? e.data()['adminId']).toString(),
                title: e.data()['title'].toString(),
                price: e.data()['price'].toDouble(),
                images: e.data()['images'] ?? [],
                storeName: e.data()['storeName'].toString(),
                category: e.data()['category'].toString(),
                description: e.data()['description'].toString(),
                dateCreate: e.data()['dateCreate'].toDate(),
                store: StoreModel.fromMap(e.data()['store'] ?? {}));
          } else {
            return null;
          }
        }).toList();
      } else {
        log('erro ao buscar dados do produto');
        return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  /// busca slides no db e retorna a lista
  Future<List<SlideModel>?> getSlides() async {
    try {
      var doc = await _db.collection('slides').get();

      if (doc.docs.isNotEmpty) {
        return doc.docs.map((e) => SlideModel.fromDocument(e)).toList();
      } else {
        log('erro ao buscar dados do produto');
        return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  /// busca TODOS os produtos no db para exibir na homepage
  /// e retorna um uma lista de models
  Future<List<ProductModel>?> getAllProductsHomePage() async {
    try {
      var query = await _db.collection('products').get();

      if (query.docs.isNotEmpty) {
        return query.docs
            .map((e) => ProductModel(
                id: e.id,
                storeId:
                    (e.data()['storeId'] ?? e.data()['adminId']).toString(),
                title: e.data()['title'].toString(),
                price: e.data()['price'].toDouble(),
                images: e.data()['images'] ?? [],
                storeName: e.data()['storeName'].toString(),
                category: e.data()['category'].toString(),
                description: e.data()['description'].toString(),
                dateCreate: e.data()['dateCreate'].toDate(),
                store: StoreModel.fromMap(e.data()['store'] ?? {})))
            .toList();
      } else {
        return null;
      }
    } on Exception catch (e) {
      print('Erro ao buscar lista de produtos. verifique conexão');
      return null;
    }
  }

  /// Busca dados de um produto usando o id informado
  Future<ProductModel?> getProductFromId(String id) async {
    var doc = await _db.collection('products').doc(id).get();

    if (doc.exists) {
      return ProductModel(
          id: doc.id,
          storeId:
              (doc.data()?['storeId'] ?? doc.data()?['adminId']).toString(),
          title: doc.data()?['title'].toString() ?? '',
          price: doc.data()?['price'].toDouble() ?? 0.0,
          images: doc.data()?['images'] ?? [],
          storeName: doc.data()?['storeName'].toString() ?? '',
          category: doc.data()?['category'].toString() ?? '',
          description: doc.data()?['description'].toString() ?? '',
          dateCreate: doc.data()?['dateCreate'].toDate(),
          store: StoreModel.fromMap(doc.data()?['store'] ?? {}));
    } else {
      log('erro ao buscar dados do produto');
      return null;
    }
  }
}

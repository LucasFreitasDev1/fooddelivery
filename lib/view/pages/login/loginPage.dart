import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/model/user_model_scoped.dart';
import 'package:food_delivery_app/view/pages/signUp/cadUsuarioPage.dart';
import 'package:food_delivery_app/view/widgets/inputDecoration.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      key: _scaffoldKey,
      body: ScopedModelDescendant<UserModel>(
        builder: (BuildContext context, Widget child, UserModel model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Stack(children: [
            Container(
              color: primaryColor,
            ),
            Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.only(top: 100),
                children: <Widget>[
                  Center(
                      child: Card(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    elevation: 30,
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildHeader(),
                          SizedBox(
                            height: 50,
                          ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: inputDecoration(
                                primaryColor, 'Email', Icons.alternate_email),
                            validator: (text) {
                              if (text.isEmpty || !text.contains("@"))
                                return "E-mail inválido!";
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _passController,
                            obscureText: true,
                            decoration: inputDecoration(
                                primaryColor, 'Senha', Icons.lock_outline),
                            validator: (text) {
                              if (text.isEmpty || text.length < 6)
                                return "Senha inválida!";
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (_emailController.text.isEmpty)
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Insira seu e-mail para recuperação!"),
                                      backgroundColor: Colors.redAccent,
                                      duration: Duration(seconds: 2),
                                    ));
                                  else {
                                    model.recoverPass(_emailController.text);
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text("Confira seu e-mail!"),
                                      backgroundColor: primaryColor,
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                },
                                textColor: Colors.black54,
                                child: Text('Esqueceu a senha?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ),
                          SizedBox(height: 50),
                          //botoes
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(25)),
                                  width: 300,
                                  height: 40,
                                  child: Expanded(
                                    child: FlatButton(
                                      child: Text(
                                        'Entrar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          model.signIn(
                                              email: _emailController.text,
                                              pass: _passController.text,
                                              onSuccess: _onSuccess,
                                              onFail: _onFail);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text("ou"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.signInGoogle(
                                        onSuccess: _cadAddress,
                                        onFail: _onFail);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: primaryColor, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          child: Image.asset(
                                            'assets/google-icon.png',
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Icon(Icons.error_outline),
                                            height: 25,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 25),
                                            child: Text(
                                              'Entrar com o Google',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                  FlatButton(
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => CadastroUsuarioPage(),
                        ));
                      },
                      child: Text(
                        'Criar uma nova conta',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      )),
                ],
              ),
            ),
          ]);
        },
      ),
    );
  }

  Container _buildHeader() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vem",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        Text(
          "Delivery",
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 30,
          ),
        ),
      ],
    ));
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _cadAddress() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}

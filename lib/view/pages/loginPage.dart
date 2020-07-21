import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/const/themeColor.dart';
import 'package:food_delivery_app/model/user_model.dart';
import 'package:food_delivery_app/view/pages/cadUsuarioPage.dart';
import 'package:food_delivery_app/const/inputDecoration.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = TextEditingController();
  var _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Color primaryColor = Themes.color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[300],
      body: ScopedModelDescendant<UserModel>(
        builder: (BuildContext context, Widget child, UserModel model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 30.0),
            child: ListView(
              padding: EdgeInsets.only(top: 60),
              children: <Widget>[
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16.0),
                    height: 500,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        //padding: EdgeInsets.only(top: 35),
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          //SizedBox(height: 30),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // HEADER
                                Container(
                                  padding: EdgeInsets.zero,
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'ss/logo-icon.png',
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(height: 10),
                                      Row(
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
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          //Container dos inputs
                          Container(
                            padding: EdgeInsets.only(),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  cursorColor: Colors.black87,
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:
                                      inputDecoration('Email', Icons.email),
                                  // ignore: missing_return
                                  validator: (text) {
                                    if (text.isEmpty || !text.contains("@"))
                                      return "E-mail inválido!";
                                  },
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _passController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:
                                      inputDecoration('Senha', Icons.lock),
                                  // ignore: missing_return
                                  validator: (text) {
                                    if (text.isEmpty || text.length < 6)
                                      return "Senha inválida!";
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
                                          model.recoverPass(
                                              _emailController.text);
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text("Confira seu e-mail!"),
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
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.yellow[800],
                                      borderRadius: BorderRadius.circular(25)),
                                  width: 300,
                                  height: 40,
                                  child: Expanded(
                                    child: FlatButton(
                                      child: Text(
                                        'Entrar',
                                        textScaleFactor: 1.3,
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {}
                                        model.signIn(
                                            email: _emailController.text,
                                            pass: _passController.text,
                                            onSuccess: _onSuccess,
                                            onFail: _onFail);
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
                                        onSuccess: _onSuccess, onFail: _onFail);
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
                                            'ss/google-icon.png',
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
                                              style: TextStyle(fontSize: 16),
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
                  ),
                ),
                FlatButton(
                    textColor: primaryColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CadastroUsuario()));
                    },
                    child: Text(
                      'Criar uma nova conta',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
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

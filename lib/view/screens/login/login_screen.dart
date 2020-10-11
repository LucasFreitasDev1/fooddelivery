import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/blocs/login_bloc.dart';
import 'package:food_delivery_app/view/screens/login/widgets/header_login.dart';
import 'package:food_delivery_app/view/screens/signUp/sign_up_screen.dart';
import 'package:food_delivery_app/view/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder<bool>(
        initialData: false,
        stream: loginBloc.outLoading,
        builder: (context, loading) {
          if (loading.data)
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
            );

          return Stack(children: [
            Container(
              color: Theme.of(context).primaryColor,
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
                          HeaderLogin(),
                          SizedBox(
                            height: 50,
                          ),
                          InputField(
                            icon: Icons.alternate_email,
                            keyboardType: TextInputType.emailAddress,
                            hint: 'Email',
                            onChanged: loginBloc.changeEmail,
                            stream: loginBloc.outEmail,
                          ),
                          SizedBox(height: 16.0),
                          InputField(
                            obscure: true,
                            hint: 'Senha',
                            icon: Icons.lock_outline,
                            done: true,
                            onChanged: loginBloc.changePassword,
                            stream: loginBloc.outPassword,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  String messageError =
                                      await loginBloc.recoveryPassword();
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(messageError == ''
                                        ? "Confira seu e-mail!"
                                        : 'Informe seu email!'),
                                    backgroundColor: messageError == ''
                                        ? Theme.of(context).primaryColor
                                        : Colors.red,
                                    duration: Duration(seconds: 2),
                                  ));
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
                                      onPressed: () async {
                                        String error = await loginBloc.submit();
                                        if (error == '') {
                                          Navigator.pop(context);
                                        } else {
                                          _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content: Text(error),
                                            backgroundColor: Colors.red,
                                          ));
                                        }
                                      },
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
                          builder: (context) => SignUpScreen(),
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
}

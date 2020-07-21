import 'package:flutter/material.dart';
import 'package:food_delivery_app/const/inputDecoration.dart';
import 'package:food_delivery_app/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastroUsuario extends StatefulWidget {
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController(text: '');

  final _emailController = TextEditingController(text: '');

  final _passController = TextEditingController(text: '');

  final _addressController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: SafeArea(
              child: ListView(
                children: <Widget>[
                  //HEADER
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        alignment: Alignment.centerLeft,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Crie uma nova conta',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
                    ),
                  ),
                  // FIM HEADER
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: inputDecoration(
                                'Nome Completo', Icons.person_outline),
                            controller: _nameController,
                            validator: (value) {
                              if (value.isEmpty || value.length < 12) {
                                return 'Digite seu nome completo';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                inputDecoration('Email', Icons.alternate_email),
                            controller: _emailController,
                            validator: (value) {
                              String pattern =
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                              bool emailValid = RegExp(pattern).hasMatch(value);
                              if (value.isEmpty) {
                                return 'Digite um email';
                              } else if (!emailValid) {
                                return 'Digite um email válido';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            decoration: inputDecoration(
                                'Senha segura', Icons.lock_outline),
                            controller: _passController,
                            validator: (value) {
                              if (value.isEmpty || value.length < 6)
                                return 'Digite uma senha segura';
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            decoration: inputDecoration(
                                'Confirme sua senha', Icons.lock_outline),
                            validator: (value) {
                              if (value.compareTo(_passController.text) != 0)
                                return 'As senhas não são iguais';
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _addressController,
                            decoration: inputDecoration('Endereço', Icons.home),
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty || value.length < 6)
                                return 'Endereço invalido!';
                            },
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                Map<String, dynamic> userData = {
                                  "name": _nameController.text,
                                  "email": _emailController.text,
                                  "address": _addressController.text
                                };

                                model.signUp(
                                    userData: userData,
                                    pass: _passController.text,
                                    onSuccess: _onSuccess,
                                    onFail: _onFail);
                              }
                            },
                            color: Colors.yellow[800],
                            child: Text(
                              'Criar',
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/widgets/inputDecoration.dart';
import 'package:food_delivery_app/model/user_model_scoped.dart';
import 'package:food_delivery_app/view/pages/address/cad_address_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastroUsuarioPage extends StatefulWidget {
  @override
  _CadastroUsuarioPageState createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _passController = TextEditingController(text: '');

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
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
                  ),
                ),
                // FIM HEADER
                SizedBox(
                  height: 50,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: inputDecoration(
                              Theme.of(context).primaryColor,
                              'Nome Completo',
                              Icons.person_outline),
                          controller: _nameController,
                          validator: (value) {
                            if (value.isEmpty || value.length < 12)
                              return 'Digite seu nome completo';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: inputDecoration(
                              Theme.of(context).primaryColor,
                              'Email',
                              Icons.alternate_email),
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
                              Theme.of(context).primaryColor,
                              'Senha segura',
                              Icons.lock_outline),
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
                              Theme.of(context).primaryColor,
                              'Confirme sua senha',
                              Icons.lock_outline),
                          validator: (value) {
                            if (value.compareTo(_passController.text) != 0)
                              return 'As senhas não são iguais';
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 45,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                Map<String, dynamic> userData = {
                                  "name": _nameController.text,
                                  "email": _emailController.text,
                                  "address": ''
                                };

                                model.signUp(
                                    userData: userData,
                                    pass: _passController.text,
                                    onSuccess: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => CadAddress(),
                                      ));
                                    },
                                    onFail: _onFail);
                              }
                            },
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Prosseguir',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}

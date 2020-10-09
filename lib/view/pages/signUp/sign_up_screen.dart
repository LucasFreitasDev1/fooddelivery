import 'package:flutter/material.dart';
import 'package:food_delivery_app/blocs/sign_up_bloc.dart';
import 'package:food_delivery_app/view/pages/address/cad_address_screen.dart';
import 'package:food_delivery_app/view/widgets/input_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SignUpBloc _signUpBloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder<bool>(
        stream: _signUpBloc.outLoading,
        builder: (context, loading) {
          if (loading.data || !loading.hasData)
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
                        InputField(
                          hint: 'Nome Completo',
                          icon: Icons.person_outline,
                          onChanged: _signUpBloc.changeName,
                          stream: _signUpBloc.outName,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputField(
                          hint: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.alternate_email,
                          onChanged: _signUpBloc.changeEmail,
                          stream: _signUpBloc.outEmail,
                        ),
                        SizedBox(height: 20),
                        InputField(
                          hint: 'Senha',
                          obscure: true,
                          icon: Icons.lock_outline,
                          onChanged: _signUpBloc.changePassword,
                          stream: _signUpBloc.outPassword,
                        ),
                        SizedBox(height: 20),
                        InputField(
                          hint: 'Confirme a senha',
                          icon: Icons.lock_outline,
                          obscure: true,
                          onChanged: _signUpBloc.changeConfirmPassword,
                          stream: _signUpBloc.outConfirmPass,
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 45,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () async {
                              String error = await _signUpBloc.signUp();
                              if (error == '') {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CadAddress(),
                                ));
                              } else {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(error),
                                  backgroundColor: Colors.red,
                                ));
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

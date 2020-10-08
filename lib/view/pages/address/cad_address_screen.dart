import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/widgets/inputDecoration.dart';
import 'package:food_delivery_app/model/user_model_scoped.dart';
import 'package:food_delivery_app/view/pages/home/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class CadAddress extends StatefulWidget {
  @override
  _CadAddressState createState() => _CadAddressState();
}

class _CadAddressState extends State<CadAddress> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _addressController = TextEditingController(text: '');
  final _complementController = TextEditingController(text: '');
  final _districtController = TextEditingController(text: '');
  final _cityController = TextEditingController(text: '');
  final _refController = TextEditingController(text: '');

  Color primaryColor = Colors.teal[400];

  Column _buildHeader(BuildContext context) {
    return Column(children: <Widget>[
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
          'Endereço para entrega',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
        ),
      ),
      // FIM HEADER
      SizedBox(
        height: 50,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) => Form(
            key: _formKey,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                children: [
                  _buildHeader(context),
                  TextFormField(
                    controller: _addressController,
                    decoration: inputDecoration(primaryColor, 'Rua', null),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4)
                        return 'Rua invalida!';
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _complementController,
                    decoration:
                        inputDecoration(primaryColor, 'Complemento', null),
                    validator: (value) {
                      if (value.isEmpty) return 'Complemento invalida!';
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _districtController,
                    decoration: inputDecoration(primaryColor, 'Bairro', null),
                    validator: (value) {
                      if (value.isEmpty) return 'Bairro invalida!';
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _cityController,
                    decoration: inputDecoration(primaryColor, 'Cidade', null),
                    validator: (value) {
                      if (value.isEmpty) return 'Cidade invalida!';
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _refController,
                    decoration:
                        inputDecoration(primaryColor, 'Referencia', null),
                    validator: (value) {
                      if (value.isEmpty) return 'Referencia invalida!';
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
                          String address =
                              '${_addressController.text}\n ${_complementController.text}\n';
                          address += '${_refController.text}\n';
                          address +=
                              '${_districtController.text}, ${_cityController.text}}';

                          model.saveUserAddress(address);
                          _onSuccess();
                        }
                      },
                      color: primaryColor,
                      child: Text(
                        'Concluir',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ]),
          ),
        ));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    });
  }
}

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/screens/login/login_screen.dart';

import '../../../../../controller/blocs/login_bloc.dart';
import '../../../../widgets/button_default.dart';
import '../../widgets/drawer.dart';
import 'widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(_pageController),
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          builder: (context, state) {
            if (state.data == LoginState.SUCCESS) {
              return FutureBuilder<QuerySnapshot>(
                future: Firestore.instance
                    .collection("users")
                    .document(_loginBloc.userModel.uid)
                    .collection("orders")
                    .getDocuments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data.documents
                        .map((doc) => OrderTile(doc.documentID))
                        .toList()
                        .reversed
                        .toList(),
                  );
                },
              );
            } else {
              return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.lock,
                        size: 80.0,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "Faça o login para acompanhar!",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      DefaultButton(
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                      )
                    ],
                  ));
            }
          }),
    );
  }
}

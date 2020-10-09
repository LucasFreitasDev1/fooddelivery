import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/blocs/login_bloc.dart';
import 'package:food_delivery_app/view/pages/login/login_screen.dart';
import 'package:food_delivery_app/view/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightBlue[50], Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        );

    return Drawer(
      elevation: 20,
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 18.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Vem\nDelivery",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    StreamBuilder<LoginState>(
                        stream: loginBloc.outState,
                        builder: (context, state) {
                          bool isLoggedIn =
                              state.data == LoginState.SUCCESS ? true : false;
                          return Positioned(
                            left: 0.0,
                            bottom: 0.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Olá,  ${isLoggedIn ? loginBloc.userModel.name : ''}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  child: Text(
                                    isLoggedIn
                                        ? "Entre ou cadastre-se >"
                                        : "Sair",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    if (isLoggedIn)
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    else
                                      loginBloc.signOut();
                                  },
                                )
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.location_on, "Anunciantes", pageController, 1),
              DrawerTile(
                  Icons.playlist_add_check, "Meus Pedidos", pageController, 2),
            ],
          )
        ],
      ),
    );
  }
}

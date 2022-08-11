import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../../tiles/drawer_tile.dart';
import '../../login/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return Drawer(
      elevation: 20,
      child: Stack(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.teal[600],
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20))),
                )
              ],
            ),
          ),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 18.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 18),
                      child: Text(
                        "Vem\nDelivery",
                        style: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    StreamBuilder<LoginState>(
                        stream: loginBloc.outState,
                        builder: (context, state) {
                          bool isLoggedIn =
                              state.data == LoginState.SUCCESS ? true : false;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Olá,  ${isLoggedIn ? loginBloc.userModel.name : ''}',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Text(
                                  !isLoggedIn
                                      ? "Entre ou cadastre-se >"
                                      : "Sair",
                                  style: TextStyle(
                                      //color: Theme.of(context).focusColor,
                                      color: Colors.tealAccent,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  if (!isLoggedIn)
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  else
                                    loginBloc.signOut();
                                },
                              )
                            ],
                          );
                        })
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.store, "Anunciantes", pageController, 1),
              DrawerTile(
                  Icons.playlist_add_check, "Meus Pedidos", pageController, 2),
            ],
          ),
        ],
      ),
    );
  }
}

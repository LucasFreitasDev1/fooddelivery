import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/blocs/login_bloc.dart';
import 'package:food_delivery_app/view/pages/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      bloc: loginBloc,
      child: MaterialApp(
        title: "Vem",
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.teal[400]),
      ),
    );
  }
}

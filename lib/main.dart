import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/blocs/login_bloc.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/view/screens/home/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginBloc loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    CartModel cartModel = CartModel(loginBloc.userModel);
    return BlocProvider<LoginBloc>(
      bloc: loginBloc,
      child: ScopedModel<CartModel>(
        model: cartModel,
        child: MaterialApp(
          title: "Vem",
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.teal[400]),
        ),
      ),
    );
  }
}

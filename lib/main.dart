import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/model/user_model.dart';
import 'package:food_delivery_app/view/pages/homePage.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return ScopedModel(
              model: CartModel(model),
              child: MaterialApp(
                title: "Vem Delivery",
                home: HomePage(),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primaryColor: Colors.teal[400]),
              ),
            );
          },
        ));
  }
}

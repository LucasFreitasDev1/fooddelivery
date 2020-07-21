import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/view/pages/cart_screen.dart';

class ButtonCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartPage()));
      },
      child: Container(
        margin: EdgeInsets.only(right: 0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Icon(Icons.local_grocery_store),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          Text(CartModel.of(context).products.length.toString())
        ]),
        padding: EdgeInsets.all(15),
        width: 90,
        decoration: BoxDecoration(
            color: Colors.yellow[800], borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}

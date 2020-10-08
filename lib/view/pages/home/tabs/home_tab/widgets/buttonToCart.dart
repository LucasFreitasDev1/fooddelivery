import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/view/pages/cart/cart_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class ButtonCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartPage()));
      },
      child: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) => Container(
          margin: EdgeInsets.only(right: 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.local_grocery_store),
                Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                Text(
                  model.products.length.toString(),
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
                ),
              ]),
          padding: EdgeInsets.all(15),
          width: 90,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }
}

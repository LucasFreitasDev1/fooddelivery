import 'package:flutter/material.dart';
import 'package:food_delivery_app/shared/dependencies_injector.dart';

import '../../../../../../controller/cart_controller.dart';
import '../../../../cart/cart_screen.dart';

class ButtonCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = inject.get<CartController>();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartPage()));
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Icon(
            Icons.local_grocery_store,
            color: Colors.white,
            size: 18,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
          Text(
            cart.products.length.toString(),
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ]),
        //padding: EdgeInsets.all(15),
        width: 60,
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}

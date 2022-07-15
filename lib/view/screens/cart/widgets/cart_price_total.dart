import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../widgets/button_default.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double priceTotal = model.getProductsPriceTotal();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do Pedido",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Divider(),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ ${priceTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                DefaultButton(
                  child: Text(
                    "Finalizar Pedido",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: buy,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/blocs/login_bloc.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/view/screens/cart/widgets/cart_price_total.dart';
import 'package:food_delivery_app/view/screens/cart/widgets/discount_card.dart';
import 'package:food_delivery_app/view/screens/login/login_screen.dart';
import 'package:food_delivery_app/view/screens/order/order_screen.dart';
import 'package:food_delivery_app/view/tiles/cart_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    bool isLoggedIn = _loginBloc.userModel.uid != null;
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.values.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if (model.isLoading && isLoggedIn) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!isLoggedIn) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.remove_shopping_cart,
                  size: 80.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Faça o login para adicionar produtos!",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.0,
                ),
                RaisedButton(
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                )
              ],
            ),
          );
        } else if (model.products == null || model.products.length == 0) {
          return Center(
            child: Text(
              "Nenhum produto no carrinho!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView(
            shrinkWrap: false,
            children: <Widget>[
              Column(
                children: model.products.keys.map((adminId) {
                  return Card(
                    shape: Border.all(color: Colors.black54),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            model.products[adminId].first.store,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Column(
                            children:
                                model.products[adminId].map((cartProduct) {
                          return CartTile(cartProduct);
                        }).toList()),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Entrega",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "R\$ ${model.getShipPrice(adminId).toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
              DiscountCard(),
              //     ShipCard(),
              CartPrice(() async {
                String orderId = await model.finishOrder();
                if (orderId != null)
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => OrderScreen(orderId)));
              }),
            ],
          );
        }
      }),
    );
  }
}

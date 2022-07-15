import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/blocs/login_bloc.dart';
import 'package:food_delivery_app/model/cart_product.dart';
import 'package:food_delivery_app/model/productData.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/view/screens/cart/cart_screen.dart';
import 'package:food_delivery_app/view/screens/login/login_screen.dart';

import '../../widgets/button_default.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  int quantity = 1;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
              aspectRatio: 0.9,
              child: Image.network(
                product.images[0],
                fit: BoxFit.contain,
              )),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Text(
                      'Vendido por ',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${product.store}',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                StreamBuilder<LoginState>(
                    stream: loginBloc.outState,
                    builder: (context, snapshot) {
                      return SizedBox(
                        height: 44.0,
                        child: DefaultButton(
                          onPressed: () {
                            if (snapshot.data == LoginState.SUCCESS) {
                              CartProduct cartProduct = CartProduct();
                              cartProduct.quantity = quantity;
                              cartProduct.pid = product.id;
                              cartProduct.category = product.category;
                              cartProduct.store = product.store;
                              cartProduct.productData = product;
                              cartProduct.adminId = product.adminId;

                              CartModel.of(context).addCartItem(cartProduct);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CartPage()));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            }
                          },
                          child: Text(
                            snapshot.data == LoginState.SUCCESS
                                ? "Adicionar ao Carrinho"
                                : "Entre para Comprar",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          color: primaryColor,
                        ),
                      );
                    }),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

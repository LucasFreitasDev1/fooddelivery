import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/productData.dart';
import 'package:food_delivery_app/view/pages/productPage.dart';

class ProductTile extends StatelessWidget {
  final ProductData product;

  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(product)));
      },
      child: Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Image.network(
              product.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    product.title,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "R\$ ${product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

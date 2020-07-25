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
          margin: EdgeInsets.all(10),
          elevation: 8.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.40,
                child: Image.network(
                  product.imgUrl,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        product.title,
                        maxLines: 1,
                        textAlign: TextAlign.center,
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

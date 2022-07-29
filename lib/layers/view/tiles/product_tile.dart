import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/product_model.dart';
import 'package:food_delivery_app/view/screens/product/productPage.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;

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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    product.images[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      product.title,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ ${product.price}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.storeName,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.0,
                          color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

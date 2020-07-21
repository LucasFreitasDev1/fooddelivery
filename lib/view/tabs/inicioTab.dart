import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/productData.dart';
import 'package:food_delivery_app/view/widgets/product_tile.dart';

// ignore: must_be_immutable
class InicioTab extends StatefulWidget {
  QuerySnapshot snapshot;

  InicioTab(this.snapshot);

  @override
  _InicioTabState createState() => _InicioTabState();
}

class _InicioTabState extends State<InicioTab> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 0.65,
        ),
        itemCount: widget.snapshot.documents.length,
        itemBuilder: (context, index) {
          ProductData data =
              ProductData.fromDocument(widget.snapshot.documents[index]);
          data.category = this.widget.snapshot.documents[index]['category'];
          return ProductTile(data);
        });
  }
}

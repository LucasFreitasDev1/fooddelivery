import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/productData.dart';
import 'package:food_delivery_app/view/widgets/product_tile.dart';

class ListProductInitial extends StatefulWidget {
  @override
  _ListProductInitialState createState() => _ListProductInitialState();
}

class _ListProductInitialState extends State<ListProductInitial> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('products').getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          else {
            return buildGridView(snapshot.data);
          }
        });
  }

  buildGridView(QuerySnapshot snapshot) {
    return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 0.9,
        ),
        itemCount: snapshot.documents.length,
        itemBuilder: (context, index) {
          String category = snapshot.documents.elementAt(index).documentID;
          QuerySnapshot items;
          Firestore.instance
              .collection('products')
              .document(category)
              .collection('items')
              .getDocuments()
              .then((value) {
            if (items.documents.isEmpty)
              return items = value;
            else
              return value.documents.map((doc) => items.documents.add(doc));
          });

          for (DocumentSnapshot item in items.documents) {
            ProductData data = ProductData.fromDocument(item);
            data.category = category;
            log('CONTEUDO DE data: ' + data.toResumedMap().toString());
            if (data != null) return ProductTile(data);
          }
          return Container(height: 0, width: 0);
        });
  }
}

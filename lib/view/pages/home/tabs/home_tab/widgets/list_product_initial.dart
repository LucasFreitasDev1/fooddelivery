import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/productData.dart';
import 'package:food_delivery_app/view/tiles/product_tile.dart';

class ListProductInitial extends StatefulWidget {
  @override
  _ListProductInitialState createState() => _ListProductInitialState();
}

class _ListProductInitialState extends State<ListProductInitial> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('products').getDocuments(),
        builder: (context, products) {
          if (!products.hasData)
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          else {
            return buildGridView(products.data);
          }
        });
  }

  GridView buildGridView(QuerySnapshot products) {
    return GridView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 0.9,
        ),
        itemCount: products.documents.length,
        itemBuilder: (context, index) {
          //       String docId;
          DocumentSnapshot doc = products.documents.elementAt(index);
          /*    if (doc.data['category'] ==
              Firestore.instance
                  .collection('category')
                  .document(doc.data['category'])
                  .documentID) {
            docId = doc.documentID;
          } else {
            docId = '';
          }
          Firestore.instance
              .collection('category')
              .document(doc.data['category'])
              .collection('items')
              .document(docId)
              .setData({
            'productId': docId,
          }); */
          ProductData data = ProductData.fromDocument(doc);
          data.category = doc.data['category'];
          return ProductTile(data);
        });
  }
}

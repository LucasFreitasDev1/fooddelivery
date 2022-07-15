import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/productData.dart';
import 'package:food_delivery_app/view/tiles/product_tile.dart';

class CategoryPage extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryPage(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(snapshot.documentID),
          centerTitle: true,
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection("category")
                .document(snapshot.documentID)
                .collection('items')
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else
                return GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(4.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: Firestore.instance
                          .collection('products')
                          .document(snapshot.data.documents
                              .elementAt(index)
                              .documentID)
                          .get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          ProductData data =
                              ProductData.fromDocument(snapshot.data);
                          data.category = snapshot.data.data['category'];
                          return ProductTile(data);
                        }
                      },
                    );
                  },
                );
            }));
  }
}

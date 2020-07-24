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
    // TODO: Corrigir bug na pagina inicial
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('products').getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          if (snapshot.hasError)
            return AlertDialog(
              content: Text('Erro'),
            );
          else {
            Future<QuerySnapshot> items = getItems(snapshot.data);

            return FutureBuilder<QuerySnapshot>(
              future: items,
              builder: (context, snapshot) => buildGridView(snapshot.data),
            );

            //return buildGridView();
          }
        });
  }

  Future<QuerySnapshot> getItems(QuerySnapshot snapshot) async {
    QuerySnapshot items;
    items = snapshot;
    items.documents.clear();

    QuerySnapshot value;
    for (var i = 0; i < snapshot.documents.length; i++) {
      String category = snapshot.documents.elementAt(i).documentID;
      value = await Firestore.instance
          .collection('products')
          .document(category)
          .collection('items')
          .getDocuments()
          .catchError((error) => log('Error: ' + error.toString()));
      items = value;
      for (var index = 0; index < value.documents.length; index++) {
        // Corrigir como os documents são adicionados ao ITEMS
        items.documents.add(value.documents.elementAt(index));
        log('ITEMS ADD: ' +
            items.documents.elementAt(0).data['title'].toString());
      }

      value.documents.clear();
    }
    return items;
  }

  GridView buildGridView(QuerySnapshot snapshot) {
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
          ProductData data =
              ProductData.fromDocument(snapshot.documents.elementAt(index));
          data.category = snapshot.documents.elementAt(index).documentID;
          log('CONTEUDO DE data: ' + data.toResumedMap().toString());
          return ProductTile(data);
        });
  }
}

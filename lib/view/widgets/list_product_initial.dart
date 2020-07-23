import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/tabs/inicioTab.dart';

class ListProductInitial extends StatefulWidget {
  Future<QuerySnapshot> snapshot;

  ListProductInitial(this.snapshot);

  @override
  _ListProductInitialState createState() => _ListProductInitialState();
}

class _ListProductInitialState extends State<ListProductInitial> {
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot snapshot;
    // TODO: Corrigir bug na pagina inicial

    return FutureBuilder<QuerySnapshot>(
        future: widget.snapshot,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          else {
            return InicioTab(snapshot.data);
          }
        });
  }
}

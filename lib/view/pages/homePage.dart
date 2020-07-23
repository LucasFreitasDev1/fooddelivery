import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/widgets/buttonToCart.dart';
import 'package:food_delivery_app/view/widgets/tab_categories.dart';
import 'package:food_delivery_app/view/widgets/drawer.dart';
import 'package:food_delivery_app/view/widgets/firstHalf.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<QuerySnapshot> snapshot =
      Firestore.instance.collection('products').getDocuments();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: ButtonCart(),
      ),
      drawer: CustomDrawer(),

      //TODO: Corrigir esse body, deixa-lo completamente com scroll

      body: SafeArea(
        child: ListView(
          children: <Widget>[
            FirstHalf(),
            TabCategories(),
            //     ListProductInitial(snapshot),
          ],
        ),
      ),
    );
  }
}

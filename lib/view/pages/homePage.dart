import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/widgets/buttonToCart.dart';
import 'package:food_delivery_app/view/widgets/list_product_initial.dart';
import 'package:food_delivery_app/view/widgets/tab_categories.dart';
import 'package:food_delivery_app/view/widgets/drawer.dart';
import 'package:food_delivery_app/view/widgets/firstHalf.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  Future<QuerySnapshot> snapshot =  Firestore.instance.collection('products').getDocuments();
  bool isLocale = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: ButtonCart(),
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
          child: isLocale
              ? ListView(
                  children: <Widget>[
                    FirstHalf(),
                    TabCategories(),
                    ListProductInitial(),
                  ],
                )
              : _buildDialog()),
    );
  }

  Dialog _buildDialog() {
    return Dialog(
      backgroundColor: Colors.grey[500],
      elevation: 10,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Não disponivel na sua região ainda! ',
              style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
            ),
            Icon(Icons.sentiment_dissatisfied)
          ],
        ),
      ),
    );
  }
}

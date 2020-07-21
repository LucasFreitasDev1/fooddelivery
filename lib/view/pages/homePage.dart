import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/tabs/bebidasTab.dart';
import 'package:food_delivery_app/view/tabs/fritosTab.dart';
import 'package:food_delivery_app/view/tabs/inicioTab.dart';
import 'package:food_delivery_app/view/tabs/lanchesTab.dart';
import 'package:food_delivery_app/view/tabs/refeicoesTab.dart';
import 'package:food_delivery_app/view/widgets/buttonToCart.dart';
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
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: ButtonCart(),
          ),
          drawer: CustomDrawer(),
          body: Column(
            children: <Widget>[
              FirstHalf(),
              FutureBuilder<QuerySnapshot>(
                  future: snapshot,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return LinearProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      );
                    else {
                      return Expanded(
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              InicioTab(snapshot.data),
                              LanchesTab(),
                              BebidasTab(),
                              FritosTab(),
                              RefeicoesTab(),
                            ]),
                      );
                    }
                  }),
            ],
          )),
    );
  }
}

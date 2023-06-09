import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/screens/home/tabs/places_tab/widgets/place_tile.dart';

import '../../widgets/drawer.dart';

class PlacesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lojas"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(_pageController),
      body: FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("admins").getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return ListView(
              children:
                  snapshot.data.documents.map((doc) => PlaceTile(doc)).toList(),
            );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/pages/category/categoryPage.dart';

class TabCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('category').getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center();
        else
          return Container(
            height: 70,
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return _buttonCategory(
                    context, snapshot.data.documents.elementAt(index));
              },
            ),
          );
      },
    );
  }

  _buttonCategory(BuildContext context, DocumentSnapshot snapshot) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CategoryPage(snapshot)));
      },
      child: Container(
        width: 115.0,
        margin: EdgeInsets.only(right: 10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30.0)),
        child: Text(
          snapshot.documentID,
          style: TextStyle(
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

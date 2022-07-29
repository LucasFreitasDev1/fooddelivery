import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../../blocs/home_bloc.dart';
import '../../../../../screens/category/categoryPage.dart';
import '../widgets/button_category.dart';

class TabCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: bloc.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            height: 70,
            child: Row(
              children: <Widget>[
                Icon(Icons.error_outline),
                Text('Erro ao carregar categorias'),
              ],
            ),
          );
        else if (snapshot.hasData) {
          return Container(
            height: 70,
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return ButtonCategory(
                    imgUrl: snapshot.data.documents.elementAt(index)['img'],
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CategoryPage(
                              snapshot.data.documents.elementAt(index))));
                    });
              },
            ),
          );
        }
        // Default
        return Container();
      },
    );
  }
}

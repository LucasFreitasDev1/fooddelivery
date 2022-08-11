import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/layers/controller/home_controller.dart';
import 'package:food_delivery_app/shared/dependencies_injector.dart';
import '../../../../../../model/button_category_model.dart';
import '../../../../../screens/category/categoryPage.dart';
import '../widgets/button_category.dart';

class TabCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final home = inject.get<HomeController>();
    return FutureBuilder<List<CategoryButtonModel>?>(
      future: home.getCategories(),
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
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var model = snapshot.data!.elementAt(index);
                return ButtonCategory(
                    imgUrl:
                        model.img, // snapshot.data!.elementAt(index)['img'],
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CategoryPage(model)));
                    });
              },
            ),
          );
        }
        // Default
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

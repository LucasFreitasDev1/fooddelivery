import 'package:flutter/material.dart';
import 'package:food_delivery_app/layers/controller/home_controller.dart';
import 'package:food_delivery_app/shared/dependencies_injector.dart';

import '../../../model/button_category_model.dart';
import '../../../model/product_model.dart';
import '../../tiles/product_tile.dart';

class CategoryPage extends StatelessWidget {
  final CategoryButtonModel categoryButtonModel;

  CategoryPage(this.categoryButtonModel);

  final home = inject.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryButtonModel.id),
          centerTitle: true,
        ),
        body: FutureBuilder<List<ProductModel?>?>(
            future: home.getProdutcsCategories(categoryButtonModel.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                var listProducts = snapshot.data!;
                return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: listProducts.length,
                    itemBuilder: (context, index) {
                      if (listProducts.isNotEmpty) {
                        return ProductTile(listProducts.elementAt(index));
                      } else {
                        return const SizedBox();
                      }
                    });
              }
            }));
  }
}

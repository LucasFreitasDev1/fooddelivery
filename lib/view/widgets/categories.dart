import 'package:flutter/material.dart';
import 'package:food_delivery_app/const/themeColor.dart';

class TabBarCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorColor: Themes.color,
      indicatorWeight: 4,
      tabs: <Widget>[
        Tab(text: 'Inicio'),
        Tab(text: 'Lanches'),
        Tab(text: 'Fritos'),
        Tab(text: 'Refeições'),
        Tab(text: 'Bebidas'),
      ],
      labelColor: Colors.black87,
    );
  }
}

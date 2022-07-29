import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/home_tab.dart';
import 'package:food_delivery_app/view/screens/home/tabs/orders_tab/orders_tab.dart';
import 'package:food_delivery_app/view/screens/home/tabs/places_tab/places_tab.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeTab(_pageController),
        PlacesTab(),
        OrdersTab(),
      ],
    );
  }
}

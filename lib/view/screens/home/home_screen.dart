import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/home_tab.dart';
import 'package:food_delivery_app/view/screens/home/tabs/orders_tab/orders_tab.dart';
import 'package:food_delivery_app/view/screens/home/tabs/places_tab/places_tab.dart';
import 'package:food_delivery_app/view/screens/home/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeTab(_pageController),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}

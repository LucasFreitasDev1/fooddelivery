import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/pages/home/tabs/home_tab/home_tab.dart';
import 'package:food_delivery_app/view/pages/home/tabs/orders_tab/orders_tab.dart';
import 'package:food_delivery_app/view/pages/home/tabs/places_tab/places_tab.dart';
import 'package:food_delivery_app/view/pages/home/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        // 0
        HomePage(_pageController),
        /*  Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: ButtonCart(),
        ), */
        Scaffold(
          // 1
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          // 2
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

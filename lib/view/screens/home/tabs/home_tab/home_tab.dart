import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/buttonToCart.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/carousel_slider_home.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/firstHalf.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/list_product_initial.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/tab_categories.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/trendings_foods_home.dart';
import 'package:food_delivery_app/view/screens/home/widgets/drawer.dart';

class HomeTab extends StatefulWidget {
  final PageController _pageController;
  HomeTab(this._pageController);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    /* QuerySnapshot productsDocuments;
    List<SlideModel> slides; */

    return RefreshIndicator(
      displacement: 50,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 1));
        setState(() {});
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 140),
          child: ButtonCart(),
        ),
        drawer: CustomDrawer(widget._pageController),
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            FirstHalf(),
            TabCategories(),
            SizedBox(height: 20),
            CarouselSliderHome(),
            TrendingsFoodsHome(),
            ListProductInitial(),
          ],
        )),
      ),
    );
  }

  Dialog _buildDialog() {
    return Dialog(
      backgroundColor: Colors.grey[500],
      elevation: 10,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Não disponivel em sua região ainda! ',
              style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
            ),
            Icon(Icons.sentiment_dissatisfied)
          ],
        ),
      ),
    );
  }
}

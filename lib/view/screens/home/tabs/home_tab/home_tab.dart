import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/buttonToCart.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/firstHalf.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/list_product_initial.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/tab_categories.dart';
import 'package:food_delivery_app/view/screens/home/widgets/drawer.dart';

class HomeTab extends StatelessWidget {
  final PageController _pageController;
  HomeTab(this._pageController);

  @override
  Widget build(BuildContext context) {
    /*     LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

      isLocal =
          _loginBloc.userModel.address['cidade'].toLowerCase() == 'carinhanha'; 

    showDialog(
        context: null,
        builder: (context) => _buildDialog(),
        barrierDismissible: false); */

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ButtonCart(),
      ),
      drawer: CustomDrawer(_pageController),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          FirstHalf(),
          TabCategories(),
          ListProductInitial(),
        ],
      )),
    );
  }

  // ignore: unused_element
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

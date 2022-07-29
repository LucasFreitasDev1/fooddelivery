import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/customAppBar.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/search_bar.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/title_app.dart';

class FirstHalf extends StatefulWidget {
  const FirstHalf({
    Key key,
  }) : super(key: key);

  @override
  _FirstHalfState createState() => _FirstHalfState();
}

class _FirstHalfState extends State<FirstHalf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 16),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          SizedBox(height: 12),
          TitleApp(),
          SizedBox(height: 15),
          SearchBar(),
          //   SizedBox(height: 10),
        ],
      ),
    );
  }
}

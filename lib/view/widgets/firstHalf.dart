import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/widgets/categories.dart';
import 'package:food_delivery_app/view/widgets/customAppBar.dart';
import 'package:food_delivery_app/view/widgets/searchBar.dart';
import 'package:food_delivery_app/const/titleHome.dart';

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 16),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          SizedBox(height: 30),
          title(),
          SizedBox(height: 30),
          SearchBar(),
          SizedBox(height: 45),
          TabBarCategories(),
        ],
      ),
    );
  }
}

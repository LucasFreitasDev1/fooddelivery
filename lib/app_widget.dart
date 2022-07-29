import 'package:flutter/material.dart';

import 'view/screens/home/home_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vem Delivery",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.teal[700],
          primaryColorDark: Color(0x01403A),
          //  accentColor: Colors.tealAccent[700],
          focusColor: Colors.tealAccent[700]),
    );
  }
}

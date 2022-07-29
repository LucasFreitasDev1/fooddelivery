import 'package:flutter/material.dart';

class HeaderLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/delivery-icons/android-icon-192x192.png',
            height: 50),
        Text(
          "Vem",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        Text(
          "Delivery",
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 30,
          ),
        ),
      ],
    ));
  }
}

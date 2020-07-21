import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

InputDecoration inputDecoration(String labelText, IconData iconData) {
  return InputDecoration(
      icon: Icon(
        iconData,
      ),
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.black87),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow[800], width: 2)));
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

InputDecoration inputDecoration(
    Color color, String labelText, IconData iconData) {
  return InputDecoration(
      icon: Icon(
        iconData,
      ),
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.black87),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(width: 2, color: color)));
}

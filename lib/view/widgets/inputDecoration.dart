import 'package:flutter/material.dart';

InputDecoration inputDecoration(
    Color primaryColor, String hintText, IconData iconData) {
  return InputDecoration(
      prefixIcon: iconData != null
          ? Icon(
              iconData,
            )
          : null,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: primaryColor),
      ));
}

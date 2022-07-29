import 'package:flutter/material.dart';
import 'colors_theme_const.dart';

class DefaultTheme {
  static get theme => ThemeData(
        primaryColor: themeGreen,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: themeBlue,
        backgroundColor: themeBlue,
        highlightColor: Colors.amberAccent,
        appBarTheme: const AppBarTheme(backgroundColor: themeBlue),
        textTheme: const TextTheme(
            bodyText2: TextStyle(
          color: themeGreen,
          fontWeight: FontWeight.w500,
        )),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                textStyle: MaterialStateProperty.all(
                    const TextStyle(color: themeGreen)))),
        buttonTheme: const ButtonThemeData(
            buttonColor: themeGreen, textTheme: ButtonTextTheme.primary),

        ///
        /// CORREÇÕES DO TEMA DARK
        primaryColorDark: themeGreen,
      );
}

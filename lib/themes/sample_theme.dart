import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(250, 125, 0, 1);
const backgroundColor = Color.fromARGB(255, 211, 211, 211);
const textColor = Colors.black;

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      fontFamily: "Muli",
      primaryColor: primaryColor,
      cardColor: backgroundColor,
      cardTheme:
          const CardTheme(shadowColor: backgroundColor, color: backgroundColor),
      drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white, surfaceTintColor: primaryColor),
      secondaryHeaderColor: primaryColor,
      appBarTheme: const AppBarTheme(
          color: primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black)),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textColor),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(28)),
  borderSide: BorderSide(color: textColor),
  gapPadding: 10,
);

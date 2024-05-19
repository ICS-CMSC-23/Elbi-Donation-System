// theme.dart
import 'package:flutter/material.dart';

// Base color for the theme (a nice shade of purple)
const Color basePurple = Color(0xFF9C27B0);

// Define tints and shades
const Color lightPurple = Color(0xFFE1BEE7); // Lighter tint of purple
const Color deepPurple = Color(0xFF7B1FA2); // Deeper shade of purple
const Color deepestPurple =
    Color.fromARGB(255, 108, 23, 144); // Deeper shade of purple
const Color darkestPurple = Color(0xFF4A148C); // Darkest shade of purple
const Color veryDarkPurple = Color(0xFF311B92); // Very dark purple

// Define a dark purple theme
ThemeData darkPurpleTheme() {
  return ThemeData(
    primaryColor: basePurple,
    cardColor: veryDarkPurple,
    iconTheme: const IconThemeData(color: lightPurple),
    listTileTheme: const ListTileThemeData(
        textColor: Colors.white, iconColor: Colors.white),
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
    secondaryHeaderColor: deepPurple,
    inputDecorationTheme: const InputDecorationTheme(
        iconColor: Colors.white,
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
        prefixIconColor: Colors.white),
    chipTheme: ChipThemeData(labelStyle: TextStyle(color: Colors.white)),

    textButtonTheme: const TextButtonThemeData(
        style:
            ButtonStyle(foregroundColor: MaterialStatePropertyAll(basePurple))),
    iconButtonTheme: const IconButtonThemeData(
        style:
            ButtonStyle(foregroundColor: MaterialStatePropertyAll(basePurple))),
    cardTheme:
        const CardTheme(shadowColor: darkestPurple, color: veryDarkPurple),
    scaffoldBackgroundColor: const Color(0xFF121212), // Very dark background
    buttonTheme: const ButtonThemeData(
      buttonColor: basePurple,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(deepestPurple),
            foregroundColor: WidgetStatePropertyAll(Colors.white))),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      color: deepestPurple,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
      basePurple.value,
      const {
        50: lightPurple,
        100: lightPurple,
        200: Color(0xFFCE93D8), // slightly lighter
        300: basePurple,
        400: Color(0xFFAB47BC), // darker
        500: basePurple,
        600: deepPurple,
        700: deepPurple,
        800: deepestPurple,
        900: veryDarkPurple,
      },
    )).copyWith(
      background: const Color(0xFF121212),
      surface: const Color(0xFF1E1E1E), // Dark surface color
      error: Colors.red[400],
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
    ),
  );
}
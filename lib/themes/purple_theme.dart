// theme.dart
import 'package:flutter/material.dart';

// Base color for the theme (a nice shade of purple)
const Color basePurple = Color(0xFF9C27B0);

// Define tints and shades
const Color lightPurple = Color(0xFFE1BEE7); // Lighter tint of purple
const Color deepPurple = Color(0xFF7B1FA2); // Deeper shade of purple

// Define a monochromatic purple theme
ThemeData purpleTheme() {
  return ThemeData(
    primaryColor: basePurple,
    cardColor: lightPurple,
    iconTheme: const IconThemeData(color: deepPurple),
    textButtonTheme: const TextButtonThemeData(
        style:
            ButtonStyle(foregroundColor: WidgetStatePropertyAll(basePurple))),
    iconButtonTheme: const IconButtonThemeData(
        style:
            ButtonStyle(foregroundColor: WidgetStatePropertyAll(basePurple))),
    cardTheme: const CardTheme(shadowColor: deepPurple, color: lightPurple),
    scaffoldBackgroundColor:
        const Color(0xFFF3E5F5), // A very light purple shade
    buttonTheme: const ButtonThemeData(
      buttonColor: deepPurple,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      color: basePurple,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
      basePurple.value,
      {
        50: lightPurple,
        100: lightPurple,
        200: const Color(0xFFCE93D8), // slightly lighter
        300: basePurple,
        400: const Color(0xFFAB47BC), // darker
        500: basePurple,
        600: deepPurple,
        700: deepPurple,
        800: deepPurple,
        900: const Color(0xFF4A148C), // deepest shade
      },
    )).copyWith(error: Colors.red[400]),
  );
}

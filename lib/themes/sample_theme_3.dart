// theme.dart
import 'package:flutter/material.dart';

// Base color for the theme (a nice shade of blue)
const Color baseBlue = Color(0xFF42A5F5);

// Define tints and shades
const Color lightBlue = Color(0xFFBBDEFB); // Lighter tint of blue
const Color deepBlue = Color(0xFF1E88E5); // Deeper shade of blue

// Define a monochromatic blue theme
ThemeData blueTheme() {
  return ThemeData(
    primaryColor: baseBlue,
    cardColor: lightBlue,
    iconTheme: const IconThemeData(color: deepBlue),
    textButtonTheme: const TextButtonThemeData(
        style:
            ButtonStyle(foregroundColor: MaterialStatePropertyAll(baseBlue))),
    iconButtonTheme: const IconButtonThemeData(
        style:
            ButtonStyle(foregroundColor: MaterialStatePropertyAll(baseBlue))),
    cardTheme: const CardTheme(shadowColor: deepBlue, color: lightBlue),
    scaffoldBackgroundColor: const Color(0xFFE3F2FD), // A very light blue shade
    buttonTheme: const ButtonThemeData(
      buttonColor: deepBlue,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      color: baseBlue,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
      baseBlue.value,
      {
        50: lightBlue,
        100: lightBlue,
        200: const Color(0xFF90CAF9), // slightly lighter
        300: baseBlue,
        400: const Color(0xFF64B5F6), // darker
        500: baseBlue,
        600: deepBlue,
        700: deepBlue,
        800: deepBlue,
        900: const Color(0xFF1565C0), // deepest shade
      },
    )).copyWith(error: Colors.red[400]),
  );
}

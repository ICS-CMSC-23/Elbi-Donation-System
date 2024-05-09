// theme.dart
import 'package:elbi_donation_system/themes/sample_theme.dart';
import 'package:flutter/material.dart';

// Base color for the theme (a nice shade of orange)
const Color baseOrange = Color(0xFFFFA726);

// Define tints and shades
const Color lightOrange = Color(0xFFFFCC80); // Lighter tint of orange
const Color deepOrange = Color(0xFFF57C00); // Deeper shade of orange

// Define a monochromatic orange theme
ThemeData orangeTheme() {
  return ThemeData(
    primaryColor: baseOrange,
    iconTheme: const IconThemeData(color: deepOrange),
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(primaryColor))),
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(primaryColor))),
    primarySwatch: MaterialColor(
      baseOrange.value,
      const {
        50: lightOrange,
        100: lightOrange,
        200: Color(0xFFFFB74D), // slightly lighter
        300: baseOrange,
        400: Color(0xFFFF8C00), // darker
        500: baseOrange,
        600: deepOrange,
        700: deepOrange,
        800: deepOrange,
        900: Color(0xFFE65100), // deepest shade
      },
    ),
    scaffoldBackgroundColor:
        const Color(0xFFFFF3E0), // A very light orange/peach
    buttonTheme: const ButtonThemeData(
      buttonColor: deepOrange,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      color: baseOrange,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  );
}

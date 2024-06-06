// theme.dart
import 'package:flutter/material.dart';

// Base color for the theme (a nice shade of purple)
const Color basePurple = Color(0xFF9C27B0);

// Define tints and shades
const Color lightPurple = Color(0xFFE1BEE7); // Lighter tint of purple
const Color deepPurple = Color(0xFF7B1FA2); // Deeper shade of purple
const Color deepestPurple =
    Color.fromARGB(255, 108, 23, 144); // Deeper shade of purple
const Color darkestPurple = Color(0xFF5D3587); // Darkest shade of purple
const Color veryDarkPurple = Color(0xFF392467); // Very dark purple

// new colors
const Color cardBackground = Color(0xFF4A1F6F);
const Color iconColor = Color(0xFFFAD079);
const Color largeText = Color(0xFFE1C2E9);
const Color smallText = Color(0xFFD28AE1);
const Color appbarColor = Color(0xFF310D47);
const Color drawerBackground = Color(0xFF2C0E3E);

// Define a dark purple theme
ThemeData darkPurpleTheme() {
  return ThemeData(
    primaryColor: basePurple,
    cardColor: cardBackground,
    iconTheme: const IconThemeData(color: iconColor),
    listTileTheme: const ListTileThemeData(
        textColor: Colors.white, iconColor: Colors.white),
    drawerTheme: const DrawerThemeData(backgroundColor: drawerBackground),
    secondaryHeaderColor: deepPurple,
    inputDecorationTheme: const InputDecorationTheme(
        iconColor: Colors.white,
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
        prefixIconColor: Colors.white),
    chipTheme: const ChipThemeData(labelStyle: TextStyle(color: Colors.white)),

    textButtonTheme: const TextButtonThemeData(
        style:
            ButtonStyle(foregroundColor: WidgetStatePropertyAll(basePurple))),
    iconButtonTheme: const IconButtonThemeData(
        style:
            ButtonStyle(foregroundColor: WidgetStatePropertyAll(basePurple))),
    cardTheme:
        const CardTheme(shadowColor: darkestPurple, color: veryDarkPurple),
    scaffoldBackgroundColor: const Color(0xFF121212), // Very dark background
    buttonTheme: const ButtonThemeData(
      buttonColor: basePurple,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
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
      surface: const Color(0xFF1E1E1E), // Dark surface color
      error: Colors.red[400],
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: smallText),
      titleLarge: TextStyle(color: largeText), 
    ),
    toggleButtonsTheme: const ToggleButtonsThemeData(
      color: smallText,
    ),
  );
}
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void toggleDarkTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}

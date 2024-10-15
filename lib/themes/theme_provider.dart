import 'package:flutter/material.dart';
import 'package:space_book/themes/darkMode.dart';
import 'package:space_book/themes/lightMode.dart';

/*
Theme Provider

this helps us to change the app from dark to light or vice-versa

 */
class ThemeProvider with ChangeNotifier {
// initailly set it as light mode
  ThemeData _themeData = lightMode;
//get the current theme
  ThemeData get themeData => _themeData;
//is it dark mode currently?
  bool get isDarkMode => _themeData == darkMode;
//set the theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    //update UI
    notifyListeners();
  }

//toggle between light & dark mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}

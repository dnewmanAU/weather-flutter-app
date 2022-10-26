import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themes extends ChangeNotifier {
  Themes(this._prefs) {
    _currentTheme = _prefs.getString('theme') ?? 'Light';
  }

  final SharedPreferences _prefs;
  String _currentTheme = '';

  String get getTheme => _currentTheme;

  void setTheme(String themeSelected) {
    _prefs.setString('theme', themeSelected);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Locations extends ChangeNotifier {
  Locations(this._prefs) {
    _location = _prefs.getString('location') ?? '';
  }

  final SharedPreferences _prefs;
  String _location = '';

  String get getLocation => _location;

  void setLocation(String locationSelected) {
    _prefs.setString('location', locationSelected);
    notifyListeners();
  }
}

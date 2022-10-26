import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recent extends ChangeNotifier {
  Recent(this._prefs) {
    _recent = _prefs.getStringList('recent') ?? <String>[];
  }

  final SharedPreferences _prefs;
  List<String> _recent = [];

  List<String> get getRecent => _recent;

  void addRecent(String recent) {
    if (_recent.contains(recent) && recent != '') {
      _recent.add(recent);
    }
    _prefs.setStringList('recent', _recent);
    notifyListeners();
  }

  void removeRecent(String recent) {
    _recent.remove(recent);
    _prefs.setStringList('recent', _recent);
    notifyListeners();
  }
}

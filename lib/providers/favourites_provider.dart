import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourites extends ChangeNotifier {
  Favourites(this._prefs) {
    _favourites = _prefs.getStringList('favourites') ?? <String>[];
  }

  final SharedPreferences _prefs;
  List<String> _favourites = [];

  List<String> get getFavourites => _favourites;

  void addFavourite(String favourite) {
    if (_favourites.contains(favourite) && favourite != '') {
      _favourites.add(favourite);
    }
    _prefs.setStringList('favourites', _favourites);
    notifyListeners();
  }

  void removeFavourite(String favourite) {
    _favourites.remove(favourite);
    _prefs.setStringList('favourites', _favourites);
    notifyListeners();
  }
}

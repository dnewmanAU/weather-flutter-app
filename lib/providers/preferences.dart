import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends ChangeNotifier {
  Preferences(this._prefs);

  final SharedPreferences _prefs;

  String get themeType {
    return _prefs.getString('theme') ?? 'Light';
  }

  set themeType(String themeSelected) {
    _prefs.setString('theme', themeSelected);
    notifyListeners();
  }

  bool get onboardedStatus {
    return _prefs.getBool('onboarded') ?? false;
  }

  set onboardedStatus(bool onboardStatus) {
    _prefs.setBool('onboarded', onboardStatus);
    notifyListeners();
  }

  String get location {
    return _prefs.getString('location') ?? '';
  }

  set location(String locationSelected) {
    _prefs.setString('location', locationSelected);
    notifyListeners();
  }

  List<String> get favourites {
    return _prefs.getStringList('favourites') ?? <String>[];
  }

  set addFavourite(String favourite) {
    final favourites = _prefs.getStringList('favourites') ?? <String>[];
    if (!favourites.contains(favourite) && favourite != '') {
      favourites.add(favourite);
    }
    _prefs.setStringList('favourites', favourites);
    notifyListeners();
  }

  set removeFavourite(String favourite) {
    final favourites = _prefs.getStringList('favourites') ?? <String>[];
    favourites.remove(favourite);
    _prefs.setStringList('favourites', favourites);
    notifyListeners();
  }

  List<String> get recent {
    return _prefs.getStringList('recent') ?? <String>[];
  }

  set addRecent(String recent) {
    final recentLocations = _prefs.getStringList('recent') ?? <String>[];
    if (!recentLocations.contains(recent) && recent != '') {
      recentLocations.add(recent);
    }
    _prefs.setStringList('recent', recentLocations);
    notifyListeners();
  }

  set removeRecent(String recent) {
    final recentLocations = _prefs.getStringList('recent') ?? <String>[];
    recentLocations.remove(recent);
    _prefs.setStringList('recent', recentLocations);
    notifyListeners();
  }
}

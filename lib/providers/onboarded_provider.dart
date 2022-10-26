import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboard extends ChangeNotifier {
  Onboard(this._prefs) {
    _onboarded = _prefs.getBool('onboarded') ?? false;
  }

  final SharedPreferences _prefs;
  bool _onboarded = false;

  bool get getOnboarded => _onboarded;

  void setOnboarded(bool onboardStatus) {
    _prefs.setBool('onboarded', onboardStatus);
    notifyListeners();
  }
}
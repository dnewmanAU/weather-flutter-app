import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_flutter_app/routes/Home.dart';
import 'package:weather_flutter_app/routes/onboarding.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialAppWithTheme();
  }
}

class MaterialAppWithTheme extends StatefulWidget {
  const MaterialAppWithTheme({Key? key}) : super(key: key);

  @override
  State<MaterialAppWithTheme> createState() => _MaterialAppWithThemeState();
}

class _MaterialAppWithThemeState extends State<MaterialAppWithTheme> {
  late SharedPreferences prefs;
  Future<bool> _getOnboarded() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarded') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
          ),
        ),
        home: FutureBuilder<bool>(
          future: _getOnboarded(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == false) {
              return const Onboarding();
            } else {
              return const Home();
            }
          },
        ),
    );
  }
}


import 'package:flutter/material.dart';
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

  final onboarded = true; // TODO implement persistent app state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => onboarded ? const Home() : const Onboarding(),
      },
    );
  }
}


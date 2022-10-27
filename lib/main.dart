import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/preferences.dart';
import '../routes/onboard.dart';
import '../routes/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Preferences(prefs),
      child: MyApp(prefs: prefs),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  // TODO add theme data
  ThemeData _buildTheme(String themeType) {
    if (themeType == 'Dark') {
      return ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        fontFamily: 'OpenSans',
        // TODO extract text data because it applies to both themes
        textTheme: const TextTheme(
          // ListTile Title
          titleMedium: TextStyle(fontSize: 24),
          // ListTile Subtitle
          bodyMedium: TextStyle(fontSize: 16),
        ),
      );
    } else {
      return ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'OpenSans',
        // TODO extract text data because it applies to both themes
        textTheme: const TextTheme(
          // ListTile Title
          titleMedium: TextStyle(fontSize: 24),
          // ListTile Subtitle
          bodyMedium: TextStyle(fontSize: 16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Preferences>(
      builder: (context, preferences, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Weather App',
          theme: _buildTheme(preferences.themeType),
          home: WeatherApp(prefs: prefs),
        );
      },
    );
  }
}

class WeatherApp extends StatefulWidget {
  final SharedPreferences prefs;

  const WeatherApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Preferences>(
      builder: (context, preferences, child) {
        if (preferences.onboardedStatus == false) {
          return Onboard(prefs: widget.prefs);
        } else {
          return Location(prefs: widget.prefs);
        }
      },
    );
  }
}

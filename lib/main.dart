import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/onboarded_provider.dart';
import '../providers/theme_provider.dart';
import '../routes/onboarding.dart';
import '../routes/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Themes(prefs)),
        ChangeNotifierProvider(create: (context) => Onboard(prefs)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Weather App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'OpenSans',
        textTheme: const TextTheme(
          // ListTile Title
          titleMedium: TextStyle(fontSize: 24),
          // ListTile Subtitle
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: const WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Onboard>(
      builder: (context, onboard, child) {
        if (onboard.getOnboarded == false) {
          return const Onboarding();
        } else {
          return const Location();
        }
      },
    );
  }
}



/*void main() {
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
  late SharedPreferences _prefs;

  Future<bool> _getOnboarded() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('onboarded') ?? false;
  }

  Future<ThemeController> _getThemeController() async {
    _prefs = await SharedPreferences.getInstance();
    return ThemeController(_prefs);
  }

  // TODO add theme data
  ThemeData _buildCurrentTheme(ThemeController themeController) {
    if (themeController.getTheme == 'dark') {
      return ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'OpenSans',
        textTheme: const TextTheme(
          // ListTile Title
          titleMedium: TextStyle(fontSize: 24),
          // ListTile Subtitle
          bodyMedium: TextStyle(fontSize: 16),
        ),
      );
    } else {
      return ThemeData(
        brightness: Brightness.light,
        fontFamily: 'OpenSans',
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
    return FutureBuilder(
      future: Future.wait([_getThemeController(), _getOnboarded()]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.data?[0] != null && snapshot.data?[1] != null) {
          return AnimatedBuilder(
            animation: snapshot.requireData[0],
            builder: (context, _) {
              return ThemeControllerProvider(
                controller: snapshot.requireData[0],
                child: MaterialApp(
                  title: 'Flutter Weather App',
                  debugShowCheckedModeBanner: false,
                  theme: _buildCurrentTheme(snapshot.requireData[0]),
                  home: snapshot.data?[1] == false
                      ? const Onboarding()
                      : const Location(),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}*/

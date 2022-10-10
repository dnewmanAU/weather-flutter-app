import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_flutter_app/routes/home.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late SharedPreferences prefs;
  setOnboarded () async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboarded', true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                setOnboarded();
                Navigator.pushReplacement(
                    context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              child: const Text('Onboard')
          ),
        ),
      ),
    );
  }
}

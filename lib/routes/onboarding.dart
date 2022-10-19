import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../routes/location.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late SharedPreferences prefs;

  var _currentIndex = 0;

  setOnboarded() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboarded', true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.7,
                  viewportFraction: 1.0,
                  onPageChanged: (index, _) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
              items: [
                Card(
                  color: Colors.lightBlueAccent,
                  child: Page1(index: _currentIndex),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  child: Page2(index: _currentIndex),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  child: Page3(index: _currentIndex),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  setOnboarded();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Location()),
                  );
                },
                child: const Text('Onboard')),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page $index'),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page $index'),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page $index'),
    );
  }
}

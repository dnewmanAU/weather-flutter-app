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
  CarouselController buttonCarouselController = CarouselController();
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
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.7,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  scrollPhysics: const BouncingScrollPhysics(),
                  onPageChanged: (index, _) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
              items: [const Page1(), const Page2(), const Page3()]
                  .map((page) => Card(
                        color: Colors.lightBlueAccent,
                        child: page,
                      ))
                  .toList(),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1, 2]
                    .map((index) => InkWell(
                          onTap: () {
                            _currentIndex = index;
                            buttonCarouselController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.linear,
                            );
                          },
                          child: Indicator(
                            rowIndex: index,
                            currentIndex: _currentIndex,
                          ),
                        ))
                    .toList()),
            ElevatedButton(
                onPressed: () {
                  if (_currentIndex == 2) {
                    setOnboarded();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Location()),
                    );
                  } else {
                    buttonCarouselController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear,
                    );
                  }
                },
                child: Text(_currentIndex == 2 ? 'Go' : 'Next')),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page 1'),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page 2'),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page 3'),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator(
      {Key? key, required this.rowIndex, required this.currentIndex})
      : super(key: key);

  final int rowIndex;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: rowIndex == currentIndex ? Colors.lightBlueAccent : Colors.grey,
      ),
    );
  }
}

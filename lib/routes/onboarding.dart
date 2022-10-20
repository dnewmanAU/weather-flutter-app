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
            Expanded(
              child: CarouselSlider(
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    scrollPhysics: const BouncingScrollPhysics(),
                    onPageChanged: (index, _) {
                      setState(() {
                        _currentIndex = index;
                      });
                    }),
                items: [const Page1(), const Page2(), const Page3()]
                    .map((page) => Container(
                          //color: Colors.lightBlueAccent,
                          child: page,
                        ))
                    .toList(),
              ),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: SizedBox(
                height: 45,
                width: 100,
                child: ElevatedButton(
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
                    child: Text(
                        _currentIndex == 2 ? 'Go' : 'Next',
                      style: const TextStyle(fontSize: 20),
                    ),
                ),
              ),
            ),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(Icons.search, size: 200),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
            child: Text(
              'Get live forecasts of practically any town or region in the world',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32),
            ),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(Icons.star_outline, size: 200),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
            child: Text(
              'Check recently viewed locations and add them to your favourites',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32),
            ),
          ),
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(Icons.swipe_down_outlined, size: 200),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
            child: Text(
              'Swipe down to get the latest forecast for your chosen location',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32),
            ),
          ),
        ],
      ),
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
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
      width: 15.0,
      height: 15.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: rowIndex == currentIndex ? Colors.blue : Colors.grey,
      ),
    );
  }
}

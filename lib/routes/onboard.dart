import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../providers/preferences.dart';
import '../widgets/onboard/page_1.dart';
import '../widgets/onboard/page_2.dart';
import '../widgets/onboard/page_3.dart';
import '../widgets/onboard/page_indicator.dart';
import '../routes/location.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  CarouselController buttonCarouselController = CarouselController();
  var _currentIndex = 0;

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
                      context.read<Preferences>().onboardedStatus = true;
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

import 'package:flutter/material.dart';

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

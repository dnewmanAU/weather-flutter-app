import 'package:flutter/material.dart';

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

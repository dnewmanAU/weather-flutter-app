import 'package:flutter/material.dart';

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

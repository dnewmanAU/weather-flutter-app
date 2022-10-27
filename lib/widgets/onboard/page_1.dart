import 'package:flutter/material.dart';

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

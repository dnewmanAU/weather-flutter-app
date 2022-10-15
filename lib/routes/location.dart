import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_flutter_app/routes/home.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _myController = TextEditingController();

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  void _setLocation(location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', location);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter a town or city',
                    ),
                    controller: _myController,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                _setLocation(_myController.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

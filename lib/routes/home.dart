import 'package:flutter/material.dart';
import 'package:weather_flutter_app/routes/settings.dart';
import 'package:weather_flutter_app/models/coordinates.dart';
import 'package:weather_flutter_app/services/location_API.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Coordinates>? ords;
  var success = false;
  var lat = 0.0;
  var lon = 0.0;

  @override
  void initState() {
    super.initState();

    // fetch latitude and longitude from API
    getLocation();
  }

  getLocation() async {
    // also accepts postcode parsed as string
    ords = await LocationAPI().getCoordinates('Gold%20Coast');
    if (ords != null) {
      setState(() {
        success = true;
      });
      lat = ords?[0].lat ?? 0.0;
      lon = ords?[0].lon ?? 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              ),
            ),
          ],
        ),
        body: Center(
          child: Visibility(
            visible: success,
            replacement: const CircularProgressIndicator(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$lat'),
                Text('$lon'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

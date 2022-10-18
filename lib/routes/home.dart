import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../routes/location.dart';
import '../routes/settings.dart';
import '../models/coordinates_model.dart';
import '../models/forecast_model.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Coordinates>? ords;
  Forecast? forecast;
  var lat = 0.0;
  var lon = 0.0;
  var locationName = '';
  var weatherType = '';
  var temp = 0.0;
  var feelsLike = 0.0;
  var tempMin = 0.0;
  var tempMax = 0.0;
  var humidity = 0;
  var windSpeed = 0.0;
  var windDeg = '';
  var sunrise = 0;
  var sunset = 0;
  var timezone = 0;
  var forecastSuccess = false;

  _getForecast() async {
    final prefs = await SharedPreferences.getInstance();
    final location = prefs.getString('location');

    // also accepts postcode parsed as string
    ords = await LocationService().getCoordinates(location);
    if (ords != null) {
      lat = ords?[0].lat ?? 0.0;
      lon = ords?[0].lon ?? 0.0;
      locationName = ords?[0].name ?? 'Unknown';
      forecast = await WeatherService().getForecast(lat, lon);
      if (forecast != null) {
        weatherType = forecast?.weather[0].main ?? '';
        temp = forecast?.main.temp ?? 0.0;
        feelsLike = forecast?.main.feelsLike ?? 0.0;
        tempMin = forecast?.main.tempMin ?? 0.0;
        tempMax = forecast?.main.tempMax ?? 0.0;
        humidity = forecast?.main.humidity ?? 0;
        windSpeed = forecast?.wind.speed ?? 0.0;
        windDeg = _windDegToDirection(forecast?.wind.deg ?? 0);
        sunrise = forecast?.sys.sunrise ?? 0;
        sunset = forecast?.sys.sunset ?? 0;
        timezone = forecast?.timezone ?? 0;
        forecastSuccess = true;
      }
    }
  }

  String _windDegToDirection(deg) {
    final direction = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    // convert wind degrees to the wind direction
    final conversion = (deg / 45 + 0.5).floor();
    return direction[conversion % 8];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getForecast(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            forecastSuccess == true) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(locationName),
                centerTitle: true,
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
                leading: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Location()),
                  ),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Current: $weatherType'),
                    Text('Temperature: $temp°'),
                    Text('Feels like: $feelsLike°'),
                    Text('Min: $tempMin°'),
                    Text('Max: $tempMax°'),
                    Text('Humidity: $humidity%'),
                    Text('Wind speed: $windSpeed km/h'),
                    Text('Wind direction: $windDeg'),
                    Text(
                        'Sunrise: ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((sunrise + timezone) * 1000, isUtc: true))}'),
                    Text(
                        'Sunset: ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((sunset + timezone) * 1000, isUtc: true))}'),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.connectionState != ConnectionState.done) {
          return const SafeArea(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Forecast offline'),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import '../routes/location.dart';
import '../routes/settings.dart';
import '../models/coordinates_model.dart';
import '../models/weather_model.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Coordinates>? ords;
  Weather? weather;
  var lat = 0.0;
  var lon = 0.0;
  var locationName = '';
  var weatherType = '';
  var weatherDetail = '';
  var temp = 0.0;
  var feelsLike = 0.0;
  var humidity = 0;
  var windSpeed = 0.0;
  var windDeg = '';
  var sunrise = 0;
  var sunset = 0;
  var timezone = 0;
  var weatherSuccess = false;

  _getWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final location = prefs.getString('location');

    // also accepts postcode parsed as string
    ords = await LocationService().getCoordinates(location);
    if (ords != null) {
      lat = ords?[0].lat ?? 0.0;
      lon = ords?[0].lon ?? 0.0;
      locationName = ords?[0].name ?? 'Unknown';
      weather = await WeatherService().getWeather(lat, lon);
      if (weather != null) {
        weatherType = weather?.weather[0].main ?? '';
        weatherDetail = weather?.weather[0].description ?? '';
        temp = weather?.main.temp ?? 0.0;
        feelsLike = weather?.main.feelsLike ?? 0.0;
        humidity = weather?.main.humidity ?? 0;
        windSpeed = weather?.wind.speed ?? 0.0;
        windDeg = _windDegToDirection(weather?.wind.deg ?? 0);
        sunrise = weather?.sys.sunrise ?? 0;
        sunset = weather?.sys.sunset ?? 0;
        timezone = weather?.timezone ?? 0;
        weatherSuccess = true;
      }
    }
  }

  IconData _getWeatherIcon(String weatherType) {
    switch (weatherType) {
      case 'Clear':
        return WeatherIcons.day_sunny;
      case 'Rain':
        return WeatherIcons.rain;
      case 'Snow':
        return WeatherIcons.snow;
      case 'Drizzle':
        return WeatherIcons.showers;
      case 'Clouds':
        return WeatherIcons.day_cloudy;
      case 'Thunderstorm':
        return WeatherIcons.thunderstorm;
      case 'Mist':
        return WeatherIcons.day_fog;
      case 'Smoke':
        return WeatherIcons.smoke;
      case 'Haze':
        return WeatherIcons.day_haze;
      case 'Dust':
        return WeatherIcons.dust;
      case 'Fog':
        return WeatherIcons.fog;
      case 'Sand':
        return WeatherIcons.sandstorm;
      case 'Ash':
        return WeatherIcons.volcano;
      case 'Squall':
        return WeatherIcons.windy;
      case 'Tornado':
        return WeatherIcons.tornado;
      default:
        return WeatherIcons.cloud;
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
      future: _getWeather(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            weatherSuccess == true) {
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 3),
                      title: Text(
                        '$temp°',
                        style: const TextStyle(fontSize: 56),
                      ),
                      subtitle: Text(
                        'Feels like $feelsLike°',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                    const Divider(
                      indent: 50,
                      endIndent: 50,
                      color: Colors.grey,
                      thickness: 1.5,
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 25),
                        title: Text(
                          weatherType,
                          style: const TextStyle(fontSize: 28),
                        ),
                        subtitle: Text(
                          '${weatherDetail[0].toUpperCase()}${weatherDetail.substring(1).toLowerCase()}',
                          style: const TextStyle(fontSize: 22),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: BoxedIcon(
                            size: 40,
                            _getWeatherIcon(weatherType),
                          ),
                        ),
                      ),
                    ),
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
                    const Text('Encountered a problem'),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Location()),
                      ),
                      child: const Text('Try again'),
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

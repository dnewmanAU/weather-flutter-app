import 'package:http/http.dart' as http;

// TODO implement weather API using location coordinates
class WeatherAPI {
  var uri = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=lat&lon=lon&appid=3264bceea6d5ed91f81110507f1c2fd7&units=metric');
}

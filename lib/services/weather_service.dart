import '../models/forecast_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Forecast?> getForecast(lat, lon) async {
    var client = http.Client();

    var uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=3264bceea6d5ed91f81110507f1c2fd7&units=metric');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      client.close();
      return forecastFromJson(json);
    } else {
      client.close();
      return null;
    }
  }
}

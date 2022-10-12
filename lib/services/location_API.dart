import 'package:weather_flutter_app/models/coordinates.dart';
import 'package:http/http.dart' as http;

class LocationAPI {
  Future<List<Coordinates>?> getCoordinates(location) async {
    var client = http.Client();

    var uri = Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$location&limit=1&appid=3264bceea6d5ed91f81110507f1c2fd7');
    var response = await client.get(uri);

    // TODO handle non-successful status codes
    if (response.statusCode == 200) {
      var json = response.body;
      return coordinatesFromJson(json);
    }
  }
}

import '../models/coordinates_model.dart';
import 'package:http/http.dart' as http;

class LocationService {
  Future<List<Coordinates>?> getCoordinates(location) async {
    var client = http.Client();

    var uri = Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$location&limit=1&appid=3264bceea6d5ed91f81110507f1c2fd7');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      client.close();
      return coordinatesFromJson(json);
    } else {
      client.close();
      throw Exception('Failed to receive OK');
    }
  }
}

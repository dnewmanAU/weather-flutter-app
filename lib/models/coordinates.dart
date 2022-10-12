import 'dart:convert';

List<Coordinates> coordinatesFromJson(String str) => List<Coordinates>.from(
    json.decode(str).map((x) => Coordinates.fromJson(x)));

String coordinatesToJson(List<Coordinates> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coordinates {
  Coordinates({
    required this.lat,
    required this.lon,
  });

  double lat;
  double lon;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

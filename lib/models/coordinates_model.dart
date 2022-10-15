import 'dart:convert';
// TODO make all json values null safe

List<Coordinates> coordinatesFromJson(String str) => List<Coordinates>.from(
    json.decode(str).map((x) => Coordinates.fromJson(x)));

class Coordinates {
  Coordinates({
    required this.name,
    required this.lat,
    required this.lon,
  });

  String name;
  double lat;
  double lon;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        name: json["name"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lon": lon,
      };
}

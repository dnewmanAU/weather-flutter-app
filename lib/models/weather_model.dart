import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    required this.weather,
    required this.main,
    required this.wind,
    required this.sys,
    required this.timezone,
  });

  List<WeatherElement> weather;
  Main main;
  Wind wind;
  Sys sys;
  int timezone;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        weather: List<WeatherElement>.from(
            json["weather"].map((x) => WeatherElement.fromJson(x))),
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        sys: Sys.fromJson(json["sys"]),
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "wind": wind.toJson(),
        "sys": sys.toJson(),
        "timezone": timezone,
      };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
  });

  double temp;
  double feelsLike;
  int humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: (json["temp"] ?? 0.0).toDouble(),
        feelsLike: (json["feels_like"] ?? 0.0).toDouble(),
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "humidity": humidity,
      };
}

class Sys {
  Sys({
    required this.sunrise,
    required this.sunset,
  });

  int sunrise;
  int sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class WeatherElement {
  WeatherElement({
    required this.main,
    required this.description,
  });

  String main;
  String description;

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        main: json["main"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "main": main,
        "description": description,
      };
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  double speed;
  int deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: (json["speed"] ?? 0.0).toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}

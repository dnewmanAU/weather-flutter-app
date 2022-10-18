import 'dart:convert';
// TODO make all json values null safe

Forecast forecastFromJson(String str) => Forecast.fromJson(json.decode(str));

class Forecast {
  Forecast({
    required this.weather,
    required this.main,
    required this.wind,
    required this.sys,
    required this.timezone,
  });

  List<Weather> weather;
  Main main;
  Wind wind;
  Sys sys;
  int timezone;

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
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
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: (json["temp"] ?? 0.0).toDouble(),
        feelsLike: (json["feels_like"] ?? 0.0).toDouble(),
        tempMin: (json["temp_min"] ?? 0.0).toDouble(),
        tempMax: (json["temp_max"] ?? 0.0).toDouble(),
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
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

class Weather {
  Weather({
    required this.main,
  });

  String main;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: json["main"],
      );

  Map<String, dynamic> toJson() => {
        "main": main,
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

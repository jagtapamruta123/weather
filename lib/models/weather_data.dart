// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

WeatherData dataFromJson(String str) => WeatherData.fromJson(json.decode(str));

String dataToJson(WeatherData data) => json.encode(data.toJson());

class WeatherData {
  WeatherData({
    required this.visibility,
    required this.main,
  });

  int visibility;
  MainObjData main;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        visibility: json["visibility"],
        main: MainObjData.fromJson(json["main"]),
      );

  Map<String, dynamic> toJson() => {
        "visibility": visibility,
        "main": main,
      };
}

class MainObjData {
  MainObjData(
      {required this.temp,
      required this.feels_like,
      required this.pressure,
      required this.temp_min,
      required this.temp_max,
      required this.humidity});

  double temp;
  double feels_like;
  int pressure;
  int humidity;
  double temp_min;
  double temp_max;
  factory MainObjData.fromJson(Map<String, dynamic> json) => MainObjData(
      temp: json["temp"],
      feels_like: json["feels_like"],
      pressure: json["pressure"],
      temp_min: json["temp_min"],
      temp_max: json["temp_max"],
      humidity: json["humidity"]);

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feels_like,
        "pressure": pressure,
        "humidity": humidity,
        "temp_min": temp_min,
        "temp_max": temp_max
      };
}

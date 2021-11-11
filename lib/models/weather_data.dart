// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

WeatherData dataFromJson(String str) => WeatherData.fromJson(json.decode(str));

String dataToJson(WeatherData data) => json.encode(data.toJson());

class WeatherData {
  WeatherData({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
   
  });

  int page;
  int perPage;
  int total;
  int totalPages;
 
  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
      
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
      
      };
}




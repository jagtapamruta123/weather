// ignore_for_file: avoid_print

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/api/api.dart';
import 'package:weather/models/weather_data.dart';

class DataServices {
  //api call http get request using flutter http package
  static Future dataService(BuildContext context, String city) async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // print(connectivityResult);

    try {
      var queryparams = {
        'q': city,
        'units': 'metric',
        'appid': "97d4f397daf19870da2731ec44699c15",
      };
      var uri = Uri.https(Api.baseUrl, Api.path, queryparams);
      final response =
          await http.get(uri, headers: {"Accept": "application/json"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        // to convert json data using modal class method.
        WeatherData jsonResponse = dataFromJson(response.body);
        print(jsonResponse);
        return jsonResponse;
      } else {
        // return response.body;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

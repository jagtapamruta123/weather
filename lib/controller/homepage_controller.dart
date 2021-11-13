import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:weather/models/weather_data.dart';
import 'package:weather/service/weather_api_service.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io' show Platform;

class HomepageController extends ControllerMVC {
  factory HomepageController([StateMVC? state]) =>
      _this ??= HomepageController._(state);
  HomepageController._(StateMVC? state) : super(state);
  static HomepageController? _this;

  late StreamSubscription<ConnectivityResult> subscription;
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final globalKey = GlobalKey<ScaffoldMessengerState>();
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  String? city;
  WeatherData? data;
  MainObjData? mainObjData;
  bool isLoading = true;

  makeApiRequest(BuildContext context) async {
    getCurrentPosition(context).then((value) async {
      if (value != null) {
        WeatherData data = await DataServices.dataService(context, value);
        setState(() {
          print(data);
          data = data;
          mainObjData = data.main;
          // data.addAll(dataItems.data);
          isLoading = false;
        });
      } else {
        print('object');
      }
    });
  }

  refreshIndicator(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      makeApiRequest(context);
    });
  }

  Future<String> getCurrentPosition(BuildContext context) async {
    final position = await geolocatorPlatform.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    city = placemarks[0].locality;
    print("city data" + city!);
    return city!.toLowerCase();
  }
}

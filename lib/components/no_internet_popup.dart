import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:weather/controller/homepage_controller.dart';

class NoInternetPopup extends StatelessWidget {
  const NoInternetPopup({
    Key? key,
    required HomepageController con,
  })  : _con = con,
        super(key: key);

  final HomepageController _con;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _con.connectionStatus == ConnectivityResult.none,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: const Center(
              child: Text(
                "No Internet !",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ));
  }
}

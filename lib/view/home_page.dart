import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:weather/components/no_internet_popup.dart';
import 'package:weather/components/shimmer_list_view.dart';
import 'package:weather/controller/homepage_controller.dart';
import 'package:weather/view/componants/reusable_text_widget.dart';

import 'componants/resuable_main_data_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  HomepageController _con = HomepageController();

  _HomePageState() : super(HomepageController()) {
    _con = controller as HomepageController;
  }

  @override
  void initState() {
    super.initState();
    _con.makeApiRequest(context);
    _con.subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _con.connectionStatus = result;
      // _con.getCurrentPosition(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        centerTitle: true,
        backgroundColor: Colors.blue.withOpacity(0.2),
        title: Text(
          "Weather App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        color: Colors.blue.withOpacity(0.2),
        child: Column(
          children: [
            Expanded(
              child: _con.data == null && _con.mainObjData == null
                  ? ShimmerListView()
                  : Container(
                      width: double.infinity,
                      color: Colors.blue.withOpacity(0.01),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Icon(
                              Icons.cloud,
                              color: Colors.white,
                              size: 35,
                            ),
                            ReusableTextWidget(
                              fontSize: 40,
                              title:
                                  _con.mainObjData!.temp.toString() + "\u2103",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                ReusableTextWidget(
                                  fontSize: 25,
                                  title: _con.city,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReusableTextWidget(
                                  fontSize: 14,
                                  title: 'Min :' +
                                      _con.mainObjData!.temp_min.toString() +
                                      "\u2103",
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                ReusableTextWidget(
                                  fontSize: 14,
                                  title: "Max : " +
                                      _con.mainObjData!.temp_max.toString() +
                                      "\u2103",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MainDataWidget(
                                    heading: "Humidity",
                                    value:
                                        _con.mainObjData!.humidity.toString()),
                                MainDataWidget(
                                    heading: "Pressure",
                                    value:
                                        _con.mainObjData!.pressure.toString()),
                                // MainDataWidget(
                                //   heading: "Visibility",
                                //   value: _con.data!.visibility.toString(),
                                // ),
                                MainDataWidget(
                                  heading: "Feels Like",
                                  value:
                                      _con.mainObjData!.feels_like.toString(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
            ),
            NoInternetPopup(con: _con)
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    super.dispose();

    _con.subscription.cancel();
  }
}

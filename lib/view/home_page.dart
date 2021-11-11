import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:weather/components/no_internet_popup.dart';
import 'package:weather/components/shimmer_list_view.dart';
import 'package:weather/controller/homepage_controller.dart';

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
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          "Weather App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              color: Colors.black,
              onRefresh: () => _con.refreshIndicator(context),
              child: _con.data.isEmpty ? ShimmerListView() : Container(),
            ),
          ),
          NoInternetPopup(con: _con)
        ],
      ),
    );
  }

  @override
  dispose() {
    super.dispose();

    _con.subscription.cancel();
  }
}

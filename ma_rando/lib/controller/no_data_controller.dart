import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class NoDataController extends StatelessWidget {
  checkLocationService() async {
    final bool locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationEnabled) {
      Geolocator.openLocationSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    //checkLocationService();

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal),
      body: FutureBuilder(
        future: Geolocator.isLocationServiceEnabled(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data!) {
              Geolocator.openLocationSettings();
            }
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitDoubleBounce(
                  color: Colors.teal,
                ),
                Text(
                  'Chargement...',
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

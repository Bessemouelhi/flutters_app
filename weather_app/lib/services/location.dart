import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Location {
  double? _latitude;
  double? _longitude;

  Future<void> getCurrentLocation(BuildContext context) async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(context, 'Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    if (permission == LocationPermission.denied) {
      showSnackBar(context, 'Location services are disabled.');
      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      showSnackBar(context, 'Location services are disabled.');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      _latitude = position.latitude;
      _longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  double? get longitude => _longitude;

  double? get latitude => _latitude;
}

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    duration: Duration(seconds: 3), //default is 4s
  );
  // Find the Scaffold in the widget tree and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/*Future checkPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

// Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Get.snackbar('', 'Location Permission Denied');
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
}*/

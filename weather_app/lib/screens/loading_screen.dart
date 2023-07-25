import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getLocation() async {
    LocationPermission checkPermission = await Geolocator.checkPermission();
    LocationPermission requestPermission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    print('getLocation');
    print(position);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('LoadingScreen : initState');
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Get the current location
            //getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}

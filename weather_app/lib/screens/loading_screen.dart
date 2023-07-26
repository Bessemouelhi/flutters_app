import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;

const apiKey = '0d58129b9a572';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  getLocation() async {
    //LocationPermission checkPermission = await Geolocator.checkPermission();
    //LocationPermission requestPermission = await Geolocator.requestPermission();
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    print('latitude : $latitude');
    print('longitude : $longitude');

    getData();
  }

  void getData() async {
    Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': '$latitude',
      'lon': '$longitude',
      'appid': '046a483de056e505394bd58129b9a572'
    });
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;
      //print(data);

      var temp = jsonDecode(data)['main']['temp'];
      var condition = jsonDecode(data)['weather'][0]['id'];
      var city = jsonDecode(data)['name'];
      var weather = jsonDecode(data)['weather'][0]['description'];
      print('weather : $weather');
      print('temp : $temp');
      print('condition : $condition');
      print('city : $city');
    }

    print(response.statusCode);
  }

  @override
  void initState() {
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
            getData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
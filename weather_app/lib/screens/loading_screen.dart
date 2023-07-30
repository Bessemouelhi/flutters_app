import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/config.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
import 'package:weather_app/services/weather.dart';

import '../services/my_connectivity.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  var weatherData;

  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  void getLocationData() async {
    //LocationPermission checkPermission = await Geolocator.checkPermission();
    //LocationPermission requestPermission = await Geolocator.requestPermission();
    WeatherModel weatherModel = WeatherModel();
    weatherData = await weatherModel.getLocationWeather(context);

    var lat = weatherData['coord']['lat'];
    var lon = weatherData['coord']['lon'];
    var temp = weatherData['main']['temp'];
    var condition = weatherData['weather'][0]['id'];
    var city = weatherData['name'];
    var weather = weatherData['weather'][0]['description'];
    print('weather : $weather');
    print('temp : $temp');
    print('condition : $condition');
    print('city : $city');
    print('lat : $lat');
    print('lon : $lon');

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    print('LoadingScreen : initState');
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String isOnline;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        isOnline = 'Mobile: Online';
        getLocationData();
        break;
      case ConnectivityResult.wifi:
        isOnline = 'WiFi: Online';
        getLocationData();
        break;
      case ConnectivityResult.none:
      default:
        isOnline = 'Offline';
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
            ElevatedButton(
              onPressed: () {
                //Get the current location
                //getLocation();
                getLocationData();
              },
              child: Text('Get Location'),
            ),
            Text(isOnline)
          ],
        ),
      ),
    );
  }
}

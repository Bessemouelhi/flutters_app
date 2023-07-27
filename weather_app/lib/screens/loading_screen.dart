import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/config.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  var weatherData;

  void getLocationData() async {
    //LocationPermission checkPermission = await Geolocator.checkPermission();
    //LocationPermission requestPermission = await Geolocator.requestPermission();
    WeatherModel weatherModel = WeatherModel();
    weatherData = await weatherModel.getLocationWeather();

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
    print('LoadingScreen : initState');
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
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
              },
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}

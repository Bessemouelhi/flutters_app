import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel model = WeatherModel();
  int? temperature;
  String message = '...';
  int? condition;
  IconData? iconData;
  String wIcon = '☁️';
  String? cityName;
  String weatherDesc = "...";

  @override
  void initState() {
    super.initState();
    print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic data) {
    double temp = data['main']['temp'];
    temperature = temp.toInt();
    message = model.getMessage(temperature!);
    condition = data['weather'][0]['id'];
    wIcon = model.getWeatherIcon(condition!);
    cityName = data['name'];
    weatherDesc = data['weather'][0]['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var data = await model.getLocationWeather();
                      setState(() {
                        updateUI(data);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(70, 211, 211, 211),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      wIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
                margin: EdgeInsets.all(15.0),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherDesc,
                  textAlign: TextAlign.right,
                  style: kShadowTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  '$message à $cityName',
                  textAlign: TextAlign.left,
                  style: kShadowTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

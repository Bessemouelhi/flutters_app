import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
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
    if (data == null) {
      temperature = 0;
      wIcon = 'Error';
      message = 'Impossible d\'avoir des donnée météo';
      weatherDesc = '...';
      cityName = '';
      return;
    }
    double temp = data['main']['temp'];
    temperature = temp.toInt();
    message = model.getMessage(temperature!);
    condition = data['weather'][0]['id'];
    wIcon = model.getWeatherIcon(condition!);
    iconData = model.getWeatherIconData(condition!);
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      print(typedName);
                      if (typedName != null) {
                        var data = await model.getCityWeather(typedName);
                        print(data);
                        setState(() {
                          updateUI(data);
                        });
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Text('$cityName', style: kShadowTextStyle),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(150, 211, 211, 211),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    // Text(
                    //   wIcon,
                    //   style: kConditionTextStyle,
                    // ),
                    Icon(
                      iconData,
                      size: 80.0,
                      color: Colors.white,
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
              // Padding(
              //   padding: EdgeInsets.only(left: 15.0),
              //   child: Text(
              //     '$message',
              //     textAlign: TextAlign.left,
              //     style: kShadowTextStyle,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

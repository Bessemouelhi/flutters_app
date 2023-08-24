import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ma_rando/services/weather_service.dart';

import '../utilities/constants.dart';

class WeatherPage extends StatefulWidget {
  final Position currentPosition;
  const WeatherPage({super.key, required this.currentPosition});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherService weatherService = WeatherService();
  int? temperature;
  String message = '...';
  int? condition;
  IconData? iconData;
  String wIcon = '☁️';
  String? cityName;
  String weatherDesc = "...";
  String? icon_url;

  @override
  void initState() {
    // TODO: implement initState
    getLocationData();
    super.initState();
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
    message = weatherService.getMessage(temperature!);
    condition = data['weather'][0]['id'];
    wIcon = weatherService.getWeatherIcon(condition!);
    iconData = weatherService.getWeatherIconData(condition!);
    cityName = data['name'];
    weatherDesc = data['weather'][0]['description'];
  }

  void getLocationData() async {
    var weatherData = await weatherService.getLocationWeather(
        context, widget.currentPosition);

    updateUI(weatherData);

    print(weatherData);
    var lat = weatherData['coord']['lat'];
    var lon = weatherData['coord']['lon'];
    var temp = weatherData['main']['temp'];
    var condition = weatherData['weather'][0]['id'];
    var city = weatherData['name'];
    var weather = weatherData['weather'][0]['description'];
    wIcon = weatherService.getWeatherIcon(condition);
    print('weather : $weather');
    print('temp : $temp');
    print('condition : $condition');
    print('city : $city');
    print('lat : $lat');
    print('lon : $lon');
    //print('icon : $icon_url');

    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return LocationScreen(
    //     locationWeather: weatherData,
    //   );
    // }));
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
                      /*var data = await model.getLocationWeather(context);
                      setState(() {
                        updateUI(data);
                      });*/
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      /*var typedName = await Navigator.push(context,
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
                      }*/
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

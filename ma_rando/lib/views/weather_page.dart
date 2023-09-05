import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ma_rando/services/weather_service.dart';

import '../models/forecast.dart';
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

  List<Forecast> filterDailyForecast(List<Forecast> forecastList) {
    Map<String, Forecast> dailyForecast = {};

    for (var forecast in forecastList) {
      String date = forecast.dateTime.toIso8601String().split("T")[0];
      if (!dailyForecast.containsKey(date)) {
        dailyForecast[date] = forecast;
      }
    }

    return dailyForecast.values.toList();
  }

  getLocationData() async {
    var weatherData = await weatherService.getLocationWeather(
        context, widget.currentPosition);

    //updateUI(weatherData);

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

    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getLocationData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SpinKitDoubleBounce(
                  color: Colors.teal,
                );
              }
              var userDoc = snapshot.data;
              updateUI(userDoc);
              return Container(
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
                          /*TextButton(
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
                              weatherService
                                  .getForecast(widget.currentPosition);
                            },
                            child: Icon(
                              Icons.location_city,
                              size: 50.0,
                            ),
                          ),*/
                        ],
                      ),
                      Text('$cityName', style: kShadowTextStyle),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(150, 211, 211, 211),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Row(
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
                            Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Text(
                                weatherDesc,
                                textAlign: TextAlign.right,
                                style: kShadowTextStyle,
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.all(15.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Text(
                          'Prévision :',
                          textAlign: TextAlign.right,
                          style: kButtonTextStyle,
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
                      Expanded(
                        child: FutureBuilder(
                          future: weatherService
                              .getForecast(widget.currentPosition),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SpinKitWave(
                                color: Colors.teal,
                              );
                            } else if (snapshot.hasData) {
                              List<Forecast> forecast =
                                  filterDailyForecast(snapshot.data!);
                              return ListView.builder(
                                itemCount: forecast?.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    tileColor: Colors.grey,
                                    title: Text(
                                        style: kForecastTextStyle,
                                        "${forecast![index].dayOfWeek} - ${forecast[index].description}"),
                                    subtitle: Text(
                                        style: kForecastTextStyle,
                                        "${forecast![index].temperature.toInt()}°C"),
                                    leading: SizedBox(
                                      width: 50,
                                      child: CachedNetworkImage(
                                        imageUrl: forecast![index].iconUrl,
                                        placeholder: (context, url) =>
                                            const SpinKitWave(
                                          color: Colors.teal,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              print(snapshot.stackTrace);
                              print('snapshot.hasError : ${snapshot.data}');
                              return Text("Error: ${snapshot.error}");
                            } else {
                              return Text("No data available");
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}

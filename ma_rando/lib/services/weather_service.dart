import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../config.dart';
import '../models/forecast.dart';
import 'network_helper.dart';

class WeatherService {
  getCityWeather(String city) async {
    Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
      'lang': 'fr',
    });

    NetworkHelper networkHelper = NetworkHelper(uri);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather(
      BuildContext context, Position position) async {
    Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': '${position.latitude}',
      'lon': '${position.longitude}',
      'appid': apiKey,
      'units': 'metric',
      'lang': 'fr',
    });

    NetworkHelper networkHelper = NetworkHelper(uri);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<List<Forecast>> getForecast(Position position) async {
    Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/forecast', {
      'lat': '${position.latitude}',
      'lon': '${position.longitude}',
      'appid': apiKey,
      'units': 'metric',
      'lang': 'fr',
    });

    print('uri $uri');

    NetworkHelper networkHelper = NetworkHelper(uri);

    var data = await networkHelper.getData();

    // Le champ "list" contient les prévisions pour chaque intervalle de 3 heures
    List<dynamic> forecastList = data["list"];

    for (var forecast in forecastList) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(forecast["dt"] * 1000);
      //double temperature = forecast["main"]["temp"];
      String description = forecast["weather"][0]["description"];
      String iconCode = forecast["weather"][0]["icon"];

      print("Date/Time: $dateTime");
      //print("Temperature: $temperature°C");
      print("Description: $description");
    }

    return forecastList.map((forecast) => Forecast.fromJson(forecast)).toList();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  IconData getWeatherIconData(int condition) {
    if (condition < 300) {
      return FontAwesomeIcons.cloudBolt;
    } else if (condition < 400) {
      return FontAwesomeIcons.cloudRain;
    } else if (condition < 600) {
      return FontAwesomeIcons.umbrella;
    } else if (condition < 700) {
      return FontAwesomeIcons.snowflake;
    } else if (condition < 800) {
      return FontAwesomeIcons.smog;
    } else if (condition == 800) {
      return FontAwesomeIcons.sun;
    } else if (condition <= 804) {
      return FontAwesomeIcons.cloud;
    } else {
      return FontAwesomeIcons.userInjured;
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'C\'est l\'heure de manger une 🍦';
    } else if (temp > 20) {
      return 'Un temps pour mettre un 👕';
    } else if (temp < 10) {
      return 'Vous aurez besoin d\'une 🧣 et d\'une paire de 🧤';
    } else {
      return 'Portez un 🧥 au cas où';
    }
  }
}

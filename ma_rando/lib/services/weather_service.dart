import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../config.dart';
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

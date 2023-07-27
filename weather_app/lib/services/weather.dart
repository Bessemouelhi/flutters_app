import '../config.dart';
import 'location.dart';
import 'networking.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': '${location.latitude}',
      'lon': '${location.longitude}',
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

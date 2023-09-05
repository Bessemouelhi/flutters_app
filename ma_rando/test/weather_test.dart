import 'package:flutter_test/flutter_test.dart';
import 'package:ma_rando/services/weather_service.dart';

void main() {
  test('Fetching city weather data', () async {
    final weatherService = WeatherService();
    final weatherData = await weatherService.getCityWeather('Paris');
    expect(weatherData['name'], 'Paris');
    expect(weatherData['weather'][0]['description'], isNotEmpty);
    expect(weatherData['main']['temp'], isNotNull);
  });
}

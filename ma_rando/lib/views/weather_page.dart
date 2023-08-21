import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ma_rando/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  final Position currentPosition;
  const WeatherPage({super.key, required this.currentPosition});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherService model = WeatherService();
  int? temperature;
  String message = '...';
  int? condition;
  IconData? iconData;
  String wIcon = '☁️';
  String? cityName;
  String weatherDesc = "...";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.currentPosition.longitude.toString()),
    );
  }
}

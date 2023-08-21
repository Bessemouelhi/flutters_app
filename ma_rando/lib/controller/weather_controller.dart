import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ma_rando/views/weather_page.dart';

import '../services/LocationManager.dart';
import 'no_data_controller.dart';

class WeatherController extends StatelessWidget {
  const WeatherController({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: LocationManager().start(),
      builder: ((context, position) => (position.hasData)
          ? WeatherPage(
              currentPosition: position.data!,
            )
          : NoDataController()),
    );
  }
}

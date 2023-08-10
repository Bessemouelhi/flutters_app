import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ma_rando/controller/no_data_controller.dart';
import 'package:ma_rando/services/LocationManager.dart';
import 'package:ma_rando/views/map_page.dart';

class HomeMapController extends StatelessWidget {
  const HomeMapController({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: LocationManager().start(),
      builder: ((context, position) => (position.hasData)
          ? MapPage(
              startPosition: position.data!,
            )
          : NoDataController()),
    );
  }
}

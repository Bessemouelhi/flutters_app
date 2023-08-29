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
        builder: (context, position) {
          // Si nous rencontrons une erreur, l'afficher à l'utilisateur
          if (position.hasError) {
            return Center(child: Text('Erreur: ${position.error}'));
          }
          // Si le Future est complété et aucune erreur n'a été rencontré,
          // créer et retourner le widget créé
          return (position.hasData)
              ? MapPage(
                  startPosition: position.data!,
                )
              // Si le Future est encore en cours ou n'a pas de données,
              // retourner la page NoDataController()
              : NoDataController();
        });
  }
}

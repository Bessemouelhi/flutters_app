import 'package:flutter_map/flutter_map.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationManager {
  //final coder = GeocodingPlatform.instance;

  Future<Position> start() async {
    final bool locationEnabled = await Geolocator.isLocationServiceEnabled();
    print('locationEnabled $locationEnabled');
    return (locationEnabled)
        ? await handlePermission()
        : await errorString("Location désactivée");
  }

  Future<Position> handlePermission() async {
    final LocationPermission locationPermission =
        await Geolocator.checkPermission();
    return await resultPermission(locationPermission);
  }

  // vérifie les permission pour chaque cas
  Future<Position> resultPermission(
      LocationPermission locationPermission) async {
    switch (locationPermission) {
      case LocationPermission.deniedForever:
        print('deniedForever');
        return errorString("Permission refusée");
      case LocationPermission.denied:
        print('denied');
        return request()
            .then((newPermission) => resultPermission(newPermission));
      case LocationPermission.unableToDetermine:
        print('unableToDetermine');
        return request()
            .then((newPermission) => resultPermission(newPermission));
      case LocationPermission.whileInUse:
        print('whileInUse');
        return await getPosition();
      case LocationPermission.always:
        print('always');
        return await getPosition();
    }
  }

  // récupère la position gps actuelle
  Future<Position> getPosition() async => await Geolocator.getCurrentPosition();

  // demande de permission
  Future<LocationPermission> request() async =>
      await Geolocator.requestPermission();

  // renvoie une erreur
  Future<Position> errorString(String err) async => await Future.error(err);

  Stream<Position> positionListener() {
    const accuracy = LocationAccuracy.high;
    const distance = 10;
    const LocationSettings locationSettings =
        LocationSettings(accuracy: accuracy, distanceFilter: distance);
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}

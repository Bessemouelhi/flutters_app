import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  final LatLng center;
  final MapController mapController;
  final double zoom;
  const MapView({
    super.key,
    required this.center,
    required this.zoom,
    required this.mapController,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(center: center, zoom: zoom, maxZoom: 16),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        CurrentLocationLayer(
            /*followOnLocationUpdate: FollowOnLocationUpdate.always,
          turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
          style: LocationMarkerStyle(
            marker: const DefaultLocationMarker(
              child: Icon(
                Icons.navigation,
                color: Colors.redAccent,
              ),
            ),
            markerSize: const Size(20, 20),
            markerDirection: MarkerDirection.heading,
          ),*/
            ),
        /*LocationMarkerLayer(
          position: LocationMarkerPosition(
            accuracy: 10,
            latitude: center.latitude,
            longitude: center.longitude,
          ),
        )*/
      ],
    );
  }
}

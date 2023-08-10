import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:ma_rando/views/map_view.dart';
import 'package:ma_rando/views/widgets/map_app_bar_view.dart';

import '../services/LocationManager.dart';

class MapPage extends StatefulWidget {
  final Position startPosition;
  const MapPage({super.key, required this.startPosition});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  //MapType mapType = MapType.simple;
  MapController mapController = MapController();
  double zoom = 12;
  LatLng center = LatLng(0, 0);
  Stream<Position> listener = LocationManager().positionListener();
  late StreamSubscription<Position> subscription;
  bool shouldFollow = true;
  Icon get followIcon => Icon(
        (shouldFollow) ? Icons.location_on : Icons.location_off,
        color: Colors.white,
      );
  //List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    center =
        LatLng(widget.startPosition.latitude, widget.startPosition.longitude);
    observePositionChanges();
    //getMarkers();
  }

  @override
  void dispose() {
    stopObserving();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MapAppBarView(
        followIcon: followIcon,
        context: context,
        menuPressed: menuPressed,
        followPosition: locationTapped,
        zoomIn: zoomIn,
        zoomOut: zoomOut,
      ),
      body: MapView(
        mapController: mapController,
        center: LatLng(
            widget.startPosition.latitude, widget.startPosition.longitude),
        zoom: 12,
      ),
    );
  }

  menuPressed() {
    //scaffoldKey.currentState?.openDrawer();
  }

  locationTapped() {
    setState(() {
      shouldFollow = !shouldFollow;
      //shouldFollow ? observePositionChanges() : stopObserving();
    });
  }

  zoomIn() {
    setState(() {
      zoom = mapController.zoom + 0.2;
      mapController.move(center, zoom);
    });
  }

  zoomOut() {
    setState(() {
      zoom = mapController.zoom - 0.2;
      mapController.move(center, zoom);
    });
  }

  observePositionChanges() {
    subscription = listener.listen((newPosition) {
      updatePosition(newPosition);
    });
    mapController.mapEventStream.listen((event) {
      if (event is MapEventLongPress) {
        final LatLng tap = event.tapPosition;
        final lat = tap.latitude;
        final lon = tap.longitude;
        //final RemarquablePlace newPlace = RemarquablePlace(lat: lat, lon: lon, city: "", adress: "");
        //final String toBeSave = newPlace.toBeSavedString;
        //DatasManager().saveDatas(toBeSave).then((_)  => getMarkers());
      }
      zoom = mapController.zoom;
    });
  }

  updatePosition(Position position) {
    setState(() {
      center = LatLng(position.latitude, position.longitude);
      mapController.move(center, zoom);
    });
  }

  stopObserving() {
    subscription.cancel();
  }
}

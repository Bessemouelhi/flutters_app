import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:ma_rando/models/parcours.dart';
import 'package:ma_rando/services/FirebaseService.dart';
import 'package:ma_rando/views/widgets/add_text_field.dart';
import 'package:ma_rando/views/widgets/custom_app_bar.dart';

import '../services/database_client.dart';

class AddParcoursPage extends StatefulWidget {
  int? listId;
  Parcours? parcours;
  LatLng? currentPosition;
  AddParcoursPage({required this.listId, this.parcours, this.currentPosition});

  @override
  AddState createState() => AddState();
}

class AddState extends State<AddParcoursPage> {
  final _currentUser = FirebaseAuth.instance.currentUser;

  late TextEditingController nomController;
  late TextEditingController distanceController;
  late TextEditingController dureeController;
  late TextEditingController difficulteController;

  String? imagePath;
  XFile? _xFile;
  String? _currentAddress;
  double? lat;
  double? lng;

  @override
  void initState() {
    print('center ${widget.currentPosition}');
    nomController = TextEditingController();
    distanceController = TextEditingController();
    dureeController = TextEditingController();
    difficulteController = TextEditingController();

    if (widget.parcours != null) {
      fillForm(widget.parcours!);
    }
    _getAddressFromLatLng();
    super.initState();
  }

  @override
  void dispose() {
    nomController.dispose();
    distanceController.dispose();
    dureeController.dispose();
    difficulteController.dispose();
    super.dispose();
  }

  Future<void> _getAddressFromLatLng() async {
    if (widget.parcours == null) {
      lat = widget.currentPosition!.latitude;
      lng = widget.currentPosition!.longitude;
    }
    await placemarkFromCoordinates(lat!, lng!)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });

      print(_currentAddress);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mobilHeight = MediaQuery.of(context).size.height * 0.25;
    return Scaffold(
      appBar: CustomAppBar(
          titleString: "Ajouter un parcours",
          btnTitle: "Valider",
          callback: addPressed),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Nouveau Parcours",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: mobilHeight,
                    margin: EdgeInsets.all(8.0),
                    color: Colors.grey,
                    child: (imagePath == null)
                        ? const Icon(Icons.camera, size: 128)
                        : Image(
                            image: FileImage(File(imagePath!)),
                            fit: BoxFit.cover),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: (() => takePicture(ImageSource.camera)),
                          icon: const Icon(Icons.camera_alt)),
                      IconButton(
                          onPressed: (() => takePicture(ImageSource.gallery)),
                          icon: const Icon(Icons.photo_library_outlined)),
                    ],
                  ),
                  AddTextfield(hint: "Nom", controller: nomController),
                  AddTextfield(
                      hint: "Distance",
                      controller: distanceController,
                      type: TextInputType.number),
                  AddTextfield(
                      hint: "Durée",
                      controller: dureeController,
                      type: TextInputType.number),
                  AddTextfield(
                      hint: "Difficulté",
                      controller: difficulteController,
                      type: TextInputType.number),
                ],
              ),
            ),
            Text('LAT: ${widget.currentPosition?.latitude ?? ""}'),
            Text('LNG: ${widget.currentPosition?.longitude ?? ""}'),
            Text('ADDRESS: ${_currentAddress ?? ""}'),
          ],
        ),
      ),
    );
  }

  fillForm(Parcours parcours) {
    nomController.text = parcours.nom!;
    distanceController.text = parcours.distance!.toString();
    dureeController.text = parcours.duree!.toString();
    difficulteController.text = parcours.difficulte!.toString();
    imagePath = parcours.image;
    lat = parcours.depart_lat;
    lng = parcours.depart_lng;
  }

  addToFirestore() async {
    FirebaseService service = FirebaseService();
    String imageUrl = await service.uploadFile(File(_xFile!.path));
    print('imageUrl $imageUrl');

    service.addParcours(
      Parcours(
          nom: nomController.text,
          distance: double.tryParse(distanceController.text) ?? 0.0,
          depart_lat: widget.currentPosition?.latitude,
          depart_lng: widget.currentPosition?.longitude,
          duree: double.tryParse(dureeController.text) ?? 0.0,
          difficulte: int.tryParse(difficulteController.text) ?? 0,
          note: 0,
          image: imageUrl,
          user_id: _currentUser?.uid),
    );
  }

  addPressed() {
    FocusScope.of(context).requestFocus(FocusNode()); //fermeture du clavier
    if (nomController.text.isEmpty) return;
    Map<String, dynamic> map = {'list': widget.listId};
    if (widget.parcours != null) map["id"] = widget.parcours?.id;
    map["nom"] = nomController.text;
    if (distanceController.text.isNotEmpty) map[""] = distanceController.text;
    double distance = double.tryParse(distanceController.text) ?? 0.0;
    map["distance"] = distance;
    if (dureeController.text.isNotEmpty) map[""] = dureeController.text;
    double duree = double.tryParse(dureeController.text) ?? 0.0;
    map["duree"] = duree;
    if (difficulteController.text.isNotEmpty)
      map[""] = difficulteController.text;
    num difficulte = int.tryParse(difficulteController.text) ?? 0;
    map["difficulte"] = difficulte;
    map["note"] = 0;
    map["depart_lat"] = widget.currentPosition?.latitude;
    map["depart_lng"] = widget.currentPosition?.longitude;
    map["date"] = DateTime.now().millisecondsSinceEpoch;
    if (imagePath != null) map["image"] = imagePath!;
    print(map);
    Parcours parcours = Parcours.fromMap(map);
    print(parcours);
    if (_currentUser != null) {
      addToFirestore();
    }
    DatabaseClient().upsert(parcours).then((success) => Navigator.pop(context));
  }

  takePicture(ImageSource source) async {
    _xFile = await ImagePicker().pickImage(source: source);
    if (_xFile == null) return;
    setState(() {
      imagePath = _xFile!.path;
    });
  }
}

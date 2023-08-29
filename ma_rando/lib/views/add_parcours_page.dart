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
  // Utilisateur actuellement connecté via Firebase
  final _currentUser = FirebaseAuth.instance.currentUser;

  // Controllers pour les champs de texte
  late TextEditingController _nomController;
  late TextEditingController _distanceController;
  late TextEditingController _dureeController;
  late TextEditingController _difficulteController;

  // Variables pour gérer les images, l'adresse et la geolocalisation
  String? _imagePath;
  XFile? _xFile;
  String? _currentAddress;
  double? _lat;
  double? _lng;

  @override
  void initState() {
    _nomController = TextEditingController();
    _distanceController = TextEditingController();
    _dureeController = TextEditingController();
    _difficulteController = TextEditingController();

    // Remplissage du formulaire si un parcours existe déjà (update)
    if (widget.parcours != null) {
      fillForm(widget.parcours!);
    }

    // Obtenir l'adresse à partir des coordonnées
    _getAddressFromLatLng();
    super.initState();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _distanceController.dispose();
    _dureeController.dispose();
    _difficulteController.dispose();
    super.dispose();
  }

  // Méthode pour obtenir l'adresse à partir des coordonnées
  Future<void> _getAddressFromLatLng() async {
    if (widget.parcours == null) {
      _lat = widget.currentPosition!.latitude;
      _lng = widget.currentPosition!.longitude;
    }
    await placemarkFromCoordinates(_lat!, _lng!)
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

  String? get _errorText {
    final text = _nomController.value.text;
    if (text.isEmpty) {
      return 'Ne peut être vide';
    }
    if (text.length < 4) {
      return 'trop court';
    }
    // return null si le text est valide
    return null;
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
                    child: (_imagePath == null)
                        ? const Icon(Icons.camera, size: 128)
                        : Image(
                            image: FileImage(File(_imagePath!)),
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
                  AddTextfield(
                      hint: "Nom",
                      controller: _nomController,
                      errorText: _errorText),
                  AddTextfield(
                      hint: "Distance",
                      controller: _distanceController,
                      type: TextInputType.number),
                  AddTextfield(
                      hint: "Durée",
                      controller: _dureeController,
                      type: TextInputType.number),
                  AddTextfield(
                      hint: "Difficulté",
                      controller: _difficulteController,
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

  // Remplit le formulaire avec les données d'un parcours existant
  fillForm(Parcours parcours) {
    _nomController.text = parcours.nom!;
    _distanceController.text = parcours.distance!.toString();
    _dureeController.text = parcours.duree!.toString();
    _difficulteController.text = parcours.difficulte!.toString();
    _imagePath = parcours.image;
    _lat = parcours.depart_lat;
    _lng = parcours.depart_lng;
  }

  // Ajoute le parcours à Firestore
  addToFirestore() async {
    FirebaseService service = FirebaseService();
    String imageUrl = await service.uploadFile(File(_xFile!.path));
    print('imageUrl $imageUrl');

    service.addParcours(
      Parcours(
          nom: _nomController.text,
          distance: double.tryParse(_distanceController.text) ?? 0.0,
          depart_lat: widget.currentPosition?.latitude,
          depart_lng: widget.currentPosition?.longitude,
          duree: double.tryParse(_dureeController.text) ?? 0.0,
          difficulte: int.tryParse(_difficulteController.text) ?? 0,
          note: 0,
          image: imageUrl,
          user_id: _currentUser?.uid),
    );
  }

  // Méthode appelée lorsque le bouton "Ajouter" est pressé
  addPressed() {
    FocusScope.of(context).requestFocus(FocusNode()); //fermeture du clavier
    if (_nomController.text.isEmpty) return;
    Map<String, dynamic> map = {'list': widget.listId};
    if (widget.parcours != null) map["id"] = widget.parcours?.id;
    map["nom"] = _nomController.text;
    if (_distanceController.text.isNotEmpty) map[""] = _distanceController.text;
    double distance = double.tryParse(_distanceController.text) ?? 0.0;
    map["distance"] = distance;
    if (_dureeController.text.isNotEmpty) map[""] = _dureeController.text;
    double duree = double.tryParse(_dureeController.text) ?? 0.0;
    map["duree"] = duree;
    if (_difficulteController.text.isNotEmpty)
      map[""] = _difficulteController.text;
    num difficulte = int.tryParse(_difficulteController.text) ?? 0;
    map["difficulte"] = difficulte;
    map["note"] = 0;
    map["depart_lat"] = widget.currentPosition?.latitude;
    map["depart_lng"] = widget.currentPosition?.longitude;
    map["date"] = DateTime.now().millisecondsSinceEpoch;
    if (_imagePath != null) map["image"] = _imagePath!;
    print(map);
    Parcours parcours = Parcours.fromMap(map);
    print(parcours);
    if (_currentUser != null) {
      addToFirestore();
    }
    DatabaseClient().upsert(parcours).then((success) => Navigator.pop(context));
  }

  // Prend une image à partir d'une source donnée (caméra ou galerie)
  takePicture(ImageSource source) async {
    _xFile = await ImagePicker().pickImage(source: source);
    if (_xFile == null) return;
    setState(() {
      _imagePath = _xFile!.path;
    });
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ma_rando/models/parcours.dart';
import 'package:ma_rando/views/widgets/add_text_field.dart';
import 'package:ma_rando/views/widgets/custom_app_bar.dart';

import '../services/database_client.dart';

class AddParcoursPage extends StatefulWidget {
  int? listId;
  AddParcoursPage({required this.listId});

  @override
  AddState createState() => AddState();
}

class AddState extends State<AddParcoursPage> {
  late TextEditingController nomController;
  late TextEditingController distanceController;
  late TextEditingController dureeController;
  late TextEditingController difficulteController;
  String? imagePath;

  @override
  void initState() {
    nomController = TextEditingController();
    distanceController = TextEditingController();
    dureeController = TextEditingController();
    difficulteController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
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
                  (imagePath == null)
                      ? const Icon(Icons.camera, size: 128)
                      : Image.file(File(imagePath!)),
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
            )
          ],
        ),
      ),
    );
  }

  addPressed() {
    FocusScope.of(context).requestFocus(FocusNode()); //fermeture du clavier
    if (nomController.text.isEmpty) return;
    Map<String, dynamic> map = {'list': widget.listId};
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
    map["date"] = DateTime.now().millisecondsSinceEpoch;
    if (imagePath != null) map["image"] = imagePath!;
    print(map);
    Parcours parcours = Parcours.fromMap(map);
    print(parcours);
    DatabaseClient().upsert(parcours).then((success) => Navigator.pop(context));
  }

  takePicture(ImageSource source) async {
    XFile? xFile = await ImagePicker().pickImage(source: source);
    if (xFile == null) return;
    setState(() {
      imagePath = xFile!.path;
    });
  }
}

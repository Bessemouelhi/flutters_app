import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ma_rando/models/parcours.dart';
import 'package:ma_rando/views/widgets/add_text_field.dart';
import 'package:ma_rando/views/widgets/custom_app_bar.dart';

import '../services/database_client.dart';

class AddParcoursPage extends StatefulWidget {
  int listId;
  AddParcoursPage({required this.listId});

  @override
  AddState createState() => AddState();
}

class AddState extends State<AddParcoursPage> {
  late TextEditingController nameController;
  late TextEditingController shopController;
  late TextEditingController priceController;
  String? imagePath;

  @override
  void initState() {
    nameController = TextEditingController();
    shopController = TextEditingController();
    priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    shopController.dispose();
    priceController.dispose();
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
                  AddTextfield(hint: "Nom", controller: nameController),
                  AddTextfield(
                      hint: "Distance",
                      controller: priceController,
                      type: TextInputType.number),
                  AddTextfield(
                      hint: "Durée",
                      controller: priceController,
                      type: TextInputType.number),
                  AddTextfield(
                      hint: "Difficulté",
                      controller: priceController,
                      type: TextInputType.number),
                  AddTextfield(hint: "Magasin", controller: shopController)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  addPressed() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (nameController.text.isEmpty) return;
    Map<String, dynamic> map = {'list': widget.listId};
    map["nom"] = nameController.text;
    if (shopController.text.isNotEmpty) map[""] = shopController.text;
    double duree = double.tryParse(priceController.text) ?? 0.0;
    map["duree"] = duree;
    if (imagePath != null) map["image"] = imagePath!;
    Parcours parcours = Parcours.fromMap(map);
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

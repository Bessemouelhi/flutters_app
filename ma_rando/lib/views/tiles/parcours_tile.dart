import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ma_rando/models/parcours.dart';

import '../../services/database_client.dart';

class ParcoursTile extends StatelessWidget {
  Parcours parcours;
  Function onDelete;
  Function onUpdate;
  ParcoursTile(
      {required this.parcours, required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    String datetime = '';
    if (parcours.date != null) {
      DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(parcours.date!);
      datetime = DateFormat('dd-MMM-yyy').format(tsdate);
    }
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(12.0),
        elevation: 7.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => {onUpdate?.call()}),
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => {onDelete?.call()}),
              ],
            ),
            if (parcours.image != null)
              Container(
                //height: height / 3,
                //width: width,
                padding: const EdgeInsets.all(5),
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRect(
                      child: Image.file(
                        File(parcours.image!),
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                parcours.nom!,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Text("distance: ${parcours.distance} km"),
            Text("duree: ${parcours.duree} "),
            Text("date: ${datetime} "),
            Text("id: ${parcours.id}")
          ],
        ),
      ),
    );
  }

  /*deleteParcours(BuildContext context, Parcours parcours) {
    print('on delete');
    DatabaseClient().removeItem(parcours).then((success) =>
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => context.widget)));
  }*/
}

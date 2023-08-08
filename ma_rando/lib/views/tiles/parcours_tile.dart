import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ma_rando/models/parcours.dart';

class ParcoursTile extends StatelessWidget {
  Parcours parcours;
  ParcoursTile({required this.parcours});

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
    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 7.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            parcours.nom!,
            style: const TextStyle(fontSize: 25),
          ),
          if (parcours.image != null)
            Container(
              //height: height / 3,
              //width: width,
              padding: const EdgeInsets.all(5),
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.file(
                    File(parcours.image!),
                    height: 150,
                    fit: BoxFit.fill,
                  )),
            ),
          Text("distance: ${parcours.distance} km"),
          Text("duree: ${parcours.duree} "),
          Text("date: ${datetime} "),
          Text("id: ${parcours.id}")
        ],
      ),
    );
  }
}

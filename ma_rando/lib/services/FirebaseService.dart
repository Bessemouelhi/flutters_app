import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ma_rando/models/parcours.dart';

class FirebaseService {
  final _currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference _parcours =
      FirebaseFirestore.instance.collection('parcours');
  FirebaseStorage _storage = FirebaseStorage.instance;

  // upload de l'image vers Firebase Storage
  Future<String> uploadFile(File file) async {
    final storageRef = _storage.ref().child('parcours/${DateTime.now()}.jpg');

    await storageRef.putFile(file);
    final imageUrl = await storageRef.getDownloadURL();

    return imageUrl;
  }

  // ajout du parcours dans la BDD Firestore
  addParcours(Parcours parcours) {
    _parcours.add({
      "nom": parcours.nom,
      "distance": parcours.distance,
      "depart_lat": parcours.depart_lat,
      "depart_lng": parcours.depart_lng,
      "duree": parcours.duree,
      "difficulte": parcours.difficulte,
      "note": parcours.note,
      "image_url": parcours.image,
      "date": DateTime.now().millisecondsSinceEpoch,
      "user_id": parcours.user_id,
    });
  }
}

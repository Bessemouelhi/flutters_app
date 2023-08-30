import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latlong2/latlong.dart';
import 'package:ma_rando/views/add_parcours_page.dart';

void main() {
  testWidgets('Tests for AddParcoursPage', (WidgetTester tester) async {
    // Créez un faux utilisateur Firebase
    // final currentUser = User(
    //   uid: '123456',
    //   // ajoutez d'autres champs si nécessaire
    // );

    // Créez un faux currentPosition
    final currentPosition = LatLng(48.8566, 2.3522);

    // Créez un widget AddParcoursPage
    final widget = MaterialApp(
      home: AddParcoursPage(
        listId: 1,
        currentPosition: currentPosition,
      ),
    );

    // Construisez le widget
    await tester.pumpWidget(widget);

    // Vérifiez si certains widgets/textes sont présents
    expect(find.text('Nouveau Parcours'), findsOneWidget);
    expect(find.byType(TextFormField),
        findsNWidgets(4)); // Vous avez 4 TextFormField
    expect(find.byType(IconButton),
        findsNWidgets(2)); // Vous avez 2 IconButton pour la photo
  });

  // Vous pouvez également ajouter des tests pour d'autres fonctionnalités, comme la validation des champs, l'interaction avec la base de données, etc.
}

import 'package:flutter/material.dart';

import '../models/parcours_list.dart';

class ParcoursListTile extends StatelessWidget {
  ParcoursList parcoursList;
  Function(ParcoursList) onPressed;
  Function(ParcoursList) onDelete;
  ParcoursListTile(
      {required this.parcoursList,
      required this.onPressed,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(parcoursList.nom),
      onTap: () {
        onPressed(parcoursList);
      },
      trailing: IconButton(
        onPressed: () {
          onDelete(parcoursList);
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}

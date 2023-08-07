import 'package:flutter/material.dart';
import 'package:ma_rando/models/parcours_list.dart';
import 'package:ma_rando/views/add_parcours_page.dart';
import 'package:ma_rando/views/widgets/custom_app_bar.dart';

class ParcoursListView extends StatefulWidget {
  ParcoursListView({required this.parcoursList});
  ParcoursList parcoursList;

  @override
  State<ParcoursListView> createState() => _ParcoursListViewState();
}

class _ParcoursListViewState extends State<ParcoursListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleString: widget.parcoursList.nom,
        btnTitle: '+',
        callback: addNewParcours,
      ),
      body: Center(child: Text('Parcours')),
    );
  }

  addNewParcours() {
    final next = AddParcoursPage(listId: widget.parcoursList.id);
    final route = MaterialPageRoute(builder: (context) => next);
    Navigator.of(context).push(route).then((value) => null);
  }
}

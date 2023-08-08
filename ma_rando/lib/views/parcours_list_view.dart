import 'package:flutter/material.dart';
import 'package:ma_rando/models/parcours_list.dart';
import 'package:ma_rando/services/database_client.dart';
import 'package:ma_rando/views/add_parcours_page.dart';
import 'package:ma_rando/views/tiles/parcours_tile.dart';
import 'package:ma_rando/views/widgets/custom_app_bar.dart';

import '../models/parcours.dart';

class ParcoursListView extends StatefulWidget {
  ParcoursListView({required this.parcoursList});
  ParcoursList parcoursList;

  @override
  State<ParcoursListView> createState() => _ParcoursListViewState();
}

class _ParcoursListViewState extends State<ParcoursListView> {
  List<Parcours> _parcours = [];
  @override
  void initState() {
    getParcours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleString: widget.parcoursList.nom,
        btnTitle: '+',
        callback: addNewParcours,
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) =>
            ParcoursTile(parcours: _parcours[index])),
        itemCount: _parcours.length,
      ),
    );
  }

  getParcours() {
    DatabaseClient().parcoursAll().then((parcours) => {
          setState(() {
            this._parcours = parcours;
          })
        });
  }

  addNewParcours() {
    final next = AddParcoursPage(listId: widget.parcoursList.id);
    print('listId : ${widget.parcoursList.id}');
    final route = MaterialPageRoute(builder: (context) => next);
    Navigator.of(context).push(route).then((value) => getParcours());
  }
}

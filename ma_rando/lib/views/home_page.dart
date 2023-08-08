import 'package:flutter/material.dart';
import 'package:ma_rando/services/database_client.dart';
import 'package:ma_rando/views/parcours_list_view.dart';
import 'package:ma_rando/views/tiles/parcours_list_tile.dart';
import 'package:ma_rando/views/widgets/add_dialog.dart';
import 'package:ma_rando/views/widgets/custom_app_bar.dart';

import '../models/parcours_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ParcoursList> lists = [];

  @override
  void initState() {
    print('iniState');
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titleString: 'Ma liste',
          btnTitle: 'Ajouter',
          callback: addItemList,
        ),
        body: ListView.separated(
            itemBuilder: ((context, index) {
              final item = lists[index];
              print("ID ===> ${item.id}");
              return ParcoursListTile(
                  parcoursList: item,
                  onPressed: onListPressed,
                  onDelete: onDeleteItem);
            }),
            separatorBuilder: ((context, index) => const Divider()),
            itemCount: lists.length));
  }

  getList() async {
    final fromDb = await DatabaseClient().allList();
    setState(() {
      print('setstate db');
      lists = fromDb;
    });
  }

  addItemList() async {
    await showDialog(
        context: context,
        builder: (context) {
          final controller = TextEditingController();
          return AddDialog(
            controller: controller,
            onAdded: () {
              handleCloseDialog();
              if (controller.text.isEmpty) return;
              DatabaseClient()
                  .addItemList(controller.text)
                  .then((success) => getList());
            },
            onCancel: handleCloseDialog,
          );
        });
  }

  handleCloseDialog() {
    Navigator.pop(context);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  onListPressed(ParcoursList parcoursList) {
    final next = ParcoursListView(parcoursList: parcoursList);
    MaterialPageRoute pageRoute = MaterialPageRoute(builder: (context) => next);
    Navigator.of(context).push(pageRoute);
  }

  onDeleteItem(ParcoursList parcoursList) {
    DatabaseClient().removeItem(parcoursList).then((success) => getList());
  }
}

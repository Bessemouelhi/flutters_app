import 'package:flutter/material.dart';
import 'package:liste_parcours/model/data_source.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('List Page'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final place = DataSource().allPlaces()[index];
            return ListTile(
              title: Text(place.name),
              leading: Text((index + 1).toString()),
              trailing: Image.asset(place.getFolderPath()),
              onTap: () {},
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(color: Colors.blue),
          itemCount: DataSource().allPlaces().length),
    );
  }
}

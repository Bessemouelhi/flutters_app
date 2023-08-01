import 'package:flutter/material.dart';

class ListPlace extends StatefulWidget {
  const ListPlace({super.key});

  @override
  State<ListPlace> createState() => _ListPlaceState();
}

class _ListPlaceState extends State<ListPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid List'),
      ),
      body: Container(),
    );
  }
}

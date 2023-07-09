import 'package:flutter/material.dart';

//the main function is the starting point for all our apps
void main() {
  runApp(
    MaterialApp(
      title: 'I AM RICH',
      home: Scaffold(
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          title: Text("I Am Rich"),
          backgroundColor: Colors.greenAccent,
        ),
        body: Center(
            child: Image(image: NetworkImage('https://picsum.photos/200'))),
      ),
    ),
  );
}

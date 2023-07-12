import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Center(
          child: Text("Let's Think"),
        ),
      ),
      body: Center(
        child: Image(
          image: AssetImage('images/think96.png'),
        ),
      ),
    ),
  ));
}

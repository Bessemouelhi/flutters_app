import 'package:flutter/material.dart';

void main() {
  runApp(XyloApp());
}

class XyloApp extends StatelessWidget {
  const XyloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: SafeArea(
          child: Center(),
        ),
      ),
    );
  }
}

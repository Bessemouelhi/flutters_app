import 'package:flutter/material.dart';
import 'package:ma_rando/views/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List Parcours',
      theme: ThemeData(primaryColor: Colors.blue),
      home: HomePage(),
    );
  }
}

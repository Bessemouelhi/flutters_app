import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randodysse/views/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randodysse',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: LoginPage(),
    );
  }
}

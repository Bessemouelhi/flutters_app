import 'package:flutter/material.dart';

import 'input_page.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  BMICalculator({super.key});

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme.copyWith(
        colorScheme: theme.colorScheme
            .copyWith(primary: Colors.red, secondary: Colors.purple),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: InputPage(),
    );
  }
}

import 'package:flutter/material.dart';

class AddTextfield extends StatelessWidget {
  String hint;
  TextEditingController controller;
  TextInputType type;
  String? errorText;

  AddTextfield(
      {required this.hint,
      required this.controller,
      this.type = TextInputType.text,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hint, errorText: errorText),
      keyboardType: type,
    );
  }
}

import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  String titleString;
  String btnTitle;
  VoidCallback callback;

  CustomAppBar(
      {required this.titleString,
      required this.btnTitle,
      required this.callback})
      : super(
          title: Text(titleString),
          actions: [
            TextButton(
              onPressed: callback,
              child: Text(btnTitle, style: TextStyle(color: Colors.white)),
            ),
          ],
        );
}

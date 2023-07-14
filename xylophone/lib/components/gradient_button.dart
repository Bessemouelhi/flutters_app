import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color color;

  ColorButton(
      {required this.onPressed, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed(),
      child: Ink(
        width: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
            constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: child),
      ),
    );
  }
}

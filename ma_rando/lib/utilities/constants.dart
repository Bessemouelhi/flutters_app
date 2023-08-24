import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 80.0,
);

const kForecastTextStyle =
    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
const kForecastTempTextStyle = TextStyle(
  fontSize: 16.0,
);

const kShadowTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 26.0,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(5.0, 5.0),
      blurRadius: 3.0,
      color: Color.fromARGB(100, 0, 0, 0),
    ),
  ],
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(Icons.location_city),
  hintText: 'Enter city name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
);

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class Forecast {
  final DateTime dateTime;
  final String dayOfWeek;
  final double temperature;
  final String description;
  final String iconUrl;

  Forecast(this.dateTime, this.dayOfWeek, this.temperature, this.description,
      this.iconUrl);

  factory Forecast.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000);
    String dayOfWeek = [
      "Lundi",
      "Mardi",
      "Mercredi",
      "Jeudi",
      "Vendredi",
      "Samedi",
      "Dimanche"
    ][dateTime.weekday - 1];
    double temperature = (json["main"]["temp"] is double)
        ? json["main"]["temp"]
        : (json["main"]["temp"] as int).toDouble();
    String description = json["weather"][0]["description"];
    String iconCode = json["weather"][0]["icon"];
    String iconUrl = "http://openweathermap.org/img/w/$iconCode.png";

    return Forecast(dateTime, dayOfWeek, temperature, description, iconUrl);
  }
}

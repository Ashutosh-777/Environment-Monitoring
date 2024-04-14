import 'package:flutter/material.dart';

class Meter {
  final airTemp;
  final airhumidity;
  final airGasSensor;
  final watertemp;
  final WaterTDS;
  final soilMoisture;
  Meter({
    required this.airTemp,
    required this.airhumidity,
    required this.airGasSensor,
    required this.watertemp,
    required this.WaterTDS,
    required this.soilMoisture,
  });
}

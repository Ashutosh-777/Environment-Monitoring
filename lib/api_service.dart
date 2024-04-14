import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
class ApiService{
  static Future<Meter> getReadings() async{
    var uri = Uri.parse('https://api.thingspeak.com/channels/2432080/feeds.json?api_key=A1TVYQ6EHMFXWKVK');
    final response = await http.get(uri);
    final body = jsonDecode(response.body);
    int len = body["feeds"].length;
    len--;
    return Meter(airTemp: body["feeds"][len]["field1"], airhumidity: body["feeds"][len]["field2"], airGasSensor: body["feeds"][len]["field3"], watertemp: body["feeds"][len]["field4"], WaterTDS: body["feeds"][len]["field5"], soilMoisture: body["feeds"][len]["field6"]);
  }
}

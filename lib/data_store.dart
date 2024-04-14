import 'package:flutter/material.dart';
import 'package:iot/model.dart';
class Data extends ChangeNotifier {
  late Meter meter;
  void addData(){

    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'model.dart';
class Data extends ChangeNotifier {
  late Meter meter;
  void addData(){

    notifyListeners();
  }
}
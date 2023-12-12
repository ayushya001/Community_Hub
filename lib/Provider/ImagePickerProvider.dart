import 'package:flutter/material.dart';

class ImageProviderClass extends ChangeNotifier {
  late String _imagePath = '';

  String get imagePath => _imagePath;

  void setImagePath(String newPath) {
    _imagePath = newPath;
    notifyListeners();
  }
}
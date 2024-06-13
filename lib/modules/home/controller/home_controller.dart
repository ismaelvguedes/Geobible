import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {

  bool isProgress = false;

  void update() {
    notifyListeners();
  }

  void startProgress() {
    isProgress = true;
    update();
  }

  void stopProgress() {
    isProgress = false;
    update();
  }
}
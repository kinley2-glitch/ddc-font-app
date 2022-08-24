import 'package:flutter/material.dart';

class EnglishState with ChangeNotifier {
  bool _english = true;

  bool get english => _english;

  void changestate() {
    _english = !_english;
    notifyListeners();
  }
}

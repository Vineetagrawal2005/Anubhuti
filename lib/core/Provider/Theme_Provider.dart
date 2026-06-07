import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isdark = false;
  bool getValue() => _isdark;
  void UpdateTheme({required bool value}) {
    _isdark = value;
    notifyListeners();
  }
}

import 'package:anubhuti/data/Repository/Ambidence_repo.dart';
import 'package:flutter/material.dart';

class AmbienceProvider extends ChangeNotifier {
  int _id = 1;
  Ambience? _ambience;

  AmbienceProvider() {
    _loadAmbience();
  }

  Future<void> _loadAmbience() async {
    _ambience = await AmbienceRepo.loadById(_id);
    notifyListeners();
  }

  void setId(int id) {
    _id = id;
    _loadAmbience();
  }

  int getId() {
    return _id;
  }

  Ambience? get currentAmbience => _ambience;

  Color getColor() {
    final hexString = _ambience?.color ?? "0xFF0D5C3A";
    return Color(int.parse(hexString));
  }
}

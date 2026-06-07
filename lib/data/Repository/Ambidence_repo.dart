import 'dart:convert';
import 'package:flutter/services.dart';

class Ambience {
  final int id;
  final String title;
  final String tag;
  final String audioFile;
  final String color;
  final List<String> suggestedMoods;

  Ambience({
    required this.id,
    required this.title,
    required this.tag,
    required this.audioFile,
    required this.color,
    required this.suggestedMoods,
  });

  factory Ambience.fromJson(Map<String, dynamic> json) {
    return Ambience(
      id: int.parse(json['id'] as String),
      title: json['title'] as String,
      tag: json['tag'] as String,
      audioFile: json['audioFile'] as String,
      color: json['color'] as String,
      suggestedMoods: List<String>.from(
        json['suggestedMoods'] as List<dynamic>,
      ),
    );
  }
}

class AmbienceRepo {
  static const String _assetPath = 'assets/ambiences.json';

  static Future<List<Ambience>> loadAll() async {
    final jsonString = await rootBundle.loadString(_assetPath);
    final List<dynamic> data = jsonDecode(jsonString) as List<dynamic>;
    return data
        .map((item) => Ambience.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<Ambience?> loadById(int id) async {
    final ambiences = await loadAll();
    return ambiences.firstWhere((ambience) => ambience.id == id);
  }

  static Future<Ambience?> loadByTitle(String title) async {
    final ambiences = await loadAll();
    return ambiences.firstWhere((ambience) => ambience.title == title);
  }

  static Future<List<Ambience>> loadByTag(String tag) async {
    final ambiences = await loadAll();
    return ambiences.where((ambience) => ambience.tag == tag).toList();
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'Journel.g.dart';

@HiveType(typeId: 0)
class Journel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  int colorValue;
  @HiveField(3)
  List<String> suggestedMoods;
  @HiveField(4)
  int duration;
  @HiveField(5)
  String descrption;

  Journel({
    required this.id,
    required this.title,
    required Color color,
    required this.suggestedMoods,
    required this.duration,
    required this.descrption,
  }) : colorValue = color.toARGB32();

  Color get color => Color(colorValue);
}

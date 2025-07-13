import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'pill.g.dart';

@HiveType(typeId: 1)
class Pill extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String dosage;
  @HiveField(2)
  final String schedule;
  @HiveField(3)
  final int iconCodePoint; // Store icon as codePoint
  @HiveField(4)
  final String? imagePath;

  Pill({
    required this.name,
    required this.dosage,
    required this.schedule,
    required this.iconCodePoint,
    this.imagePath,
  });

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');
} 
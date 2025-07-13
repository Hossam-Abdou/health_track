import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'medical_file.g.dart';

@HiveType(typeId: 0)
class MedicalFile extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final int iconCodePoint; // Store icon as codePoint
  @HiveField(3)
  final String filePath; // Actual file path
  @HiveField(4)
  final String? notes; // Optional notes

  MedicalFile({
    required this.name,
    required this.date,
    required this.iconCodePoint,
    required this.filePath,
    this.notes,
  });

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');
} 
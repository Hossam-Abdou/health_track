import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'visit.g.dart';

@HiveType(typeId: 2)
class Visit extends HiveObject {
  @HiveField(0)
  final String doctor;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final String reason;
  @HiveField(3)
  final int iconCodePoint; // Store icon as codePoint
  @HiveField(4)
  final String? prescriptionImagePath; // Optional prescription image/PDF
  @HiveField(5)
  final String? notes; // Optional notes

  Visit({
    required this.doctor,
    required this.date,
    required this.reason,
    required this.iconCodePoint,
    this.prescriptionImagePath,
    this.notes,
  });

  IconData get icon =>  IconData(iconCodePoint, fontFamily: 'MaterialIcons');
} 
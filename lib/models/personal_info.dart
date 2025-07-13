import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'personal_info.g.dart';

@HiveType(typeId: 4)
class PersonalInfo extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String dob;
  @HiveField(2)
  final String gender;
  @HiveField(3)
  final String bloodType;
  @HiveField(4)
  final String diseases;
  @HiveField(5)
  final String emergencyContactName;
  @HiveField(6)
  final String emergencyContactPhone;

  PersonalInfo({
    required this.name,
    required this.dob,
    required this.gender,
    required this.bloodType,
    required this.diseases,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
  });
} 
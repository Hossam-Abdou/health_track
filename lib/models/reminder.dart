import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 5)
class Reminder extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<TimeOfDay> notificationTimes;

  @HiveField(2)
  bool notificationOn;

  @HiveField(3)
  String frequency;

  Reminder({
    required this.name,
    required this.notificationTimes,
    required this.notificationOn,
    required this.frequency,
  });
} 
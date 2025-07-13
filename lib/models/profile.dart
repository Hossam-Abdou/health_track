import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'profile.g.dart';

@HiveType(typeId: 3)
class Profile extends HiveObject {
  @HiveField(0)
  final String avatarUrl;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;

  Profile({
    required this.avatarUrl,
    required this.name,
    required this.email,
  });
} 
import 'package:flutter/material.dart';

class CustomSnackBar {
  final String message;
  final Color color;

  const CustomSnackBar({required this.message, this.color = Colors.green});

  SnackBar customSnackBar() {
    return SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    );
  }
}
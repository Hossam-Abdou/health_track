import 'dart:io';
import 'package:flutter/material.dart';

class PrescriptionImageViewerScreen extends StatelessWidget {
  final String imagePath;
  const PrescriptionImageViewerScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          child: Image.file(File(imagePath)),
        ),
      ),
    );
  }
} 
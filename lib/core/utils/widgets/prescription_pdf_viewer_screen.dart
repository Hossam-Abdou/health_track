import 'package:flutter/material.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrescriptionPdfViewerScreen extends StatelessWidget {
  final String pdfPath;
  const PrescriptionPdfViewerScreen({Key? key, required this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SfPdfViewer.file(File(pdfPath)),
    );
  }
} 
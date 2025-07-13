import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';

class CustomFileViewerScreen extends StatelessWidget {
  final String filePath;
  final String fileName;

  const CustomFileViewerScreen({
    super.key,
    required this.filePath,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fileName),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: _buildFileViewer(),
    );
  }

  Widget _buildFileViewer() {
    final file = File(filePath);
    final extension = filePath.split('.').last.toLowerCase();

    if (extension == 'pdf') {
      return SfPdfViewer.file(file);
    } else if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension)) {
      return Center(
        child: InteractiveViewer(
          child: Image.file(
            file,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      'Error loading image',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.file_present, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'File type not supported',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
    }
  }
} 
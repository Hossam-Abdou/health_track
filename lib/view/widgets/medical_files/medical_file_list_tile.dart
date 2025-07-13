import 'package:flutter/material.dart';
import 'package:untitled3/config/routes.dart';
import '../../../models/medical_file.dart';
import '../../screens/medical_files/custom_file_viewer.dart';

class MedicalFileListTile extends StatelessWidget {
  final MedicalFile file;
  final VoidCallback? onDelete;
  const MedicalFileListTile({Key? key, required this.file, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.red,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(file.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(file.date),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(file.icon, color: Theme.of(context).primaryColor),
            if (onDelete != null) ...[
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
                tooltip: 'Delete',
              ),
            ],
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.fileViewDetails,
            arguments: [
              file.filePath,
              file.name,
            ],
          );
        },
      ),
    );
  }
} 
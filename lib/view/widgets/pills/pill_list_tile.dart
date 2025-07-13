import 'package:flutter/material.dart';
import 'dart:io';
import '../../../models/pill.dart';

class PillListTile extends StatelessWidget {
  final Pill pill;
  final VoidCallback? onDelete;
  const PillListTile({Key? key, required this.pill, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Medicine Image or Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: pill.imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(pill.imagePath!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            pill.icon,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.medical_information_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
            ),
            const SizedBox(width: 16),
            // Medicine Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name:',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey
                        ),
                      ),
                      const SizedBox(width: 6),

                      Text(
                        pill.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Dosage:',
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.grey
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        pill.dosage,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        'Schedule:',
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.grey
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        pill.schedule,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (onDelete != null) ...[
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
                tooltip: 'Delete',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
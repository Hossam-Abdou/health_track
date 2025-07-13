import 'package:flutter/material.dart';
import '../../../models/visit.dart';

class VisitListTile extends StatelessWidget {
  final Visit visit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  const VisitListTile({Key? key, required this.visit, this.onDelete, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListTile(
            title: Text(visit.doctor, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(visit.date),
                Text(visit.reason, style: const TextStyle(fontSize: 12)),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(visit.icon, color: Theme.of(context).primaryColor),
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
        ),
      ),
    );
  }
} 
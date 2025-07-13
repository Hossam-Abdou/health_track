import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled3/core/constants/app_colors.dart';

import '../../../main.dart';

class TaskHeaderCard extends StatelessWidget {
  final String frequency;
  final String medicineName;
  // final List<String> schedule;
  final List<TimeOfDay> notificationTimes;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskHeaderCard({
    super.key,
    required this.frequency,
    required this.medicineName,
    // required this.schedule,
    required this.notificationTimes,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_pharmacy, color: Colors.lightBlueAccent),
                  const SizedBox(width: 8),
                  Text(medicineName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: onEdit,
                    tooltip: 'Edit',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: onDelete,
                    tooltip: 'Delete',
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: Colors.grey),

          const SizedBox(height: 8),
          _buildRowTitle('Frequency', frequency),
          // const SizedBox(height: 8),
          // _buildRowWrap('Schedule', schedule),
          const SizedBox(height: 8),
          _buildRowWrap(context, 'Notification Time', notificationTimes),
        ],
      ),
    );
  }

  Widget _buildRowTitle(String title, String value) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(title, style: const TextStyle(color: Colors.grey))),
        Expanded(flex: 5, child: Text(value, style: const TextStyle(color: Colors.black))),
      ],
    );
  }

  Widget _buildRowWrap(BuildContext context, String title, List<TimeOfDay> items) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Text(title, style: const TextStyle(color: Colors.grey))),
        Expanded(
          flex: 5,
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: items.map((item) => Chip(
              label: Text(item.format(context), style: const TextStyle(color: Colors.black)),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(side: BorderSide(color: Colors.lightBlueAccent)),
            )).toList(),
          ),
        ),
      ],
    );
  }
}

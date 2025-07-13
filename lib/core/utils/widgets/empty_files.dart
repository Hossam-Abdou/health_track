import 'package:flutter/material.dart';

class EmptyFiles extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const EmptyFiles({
    super.key,
    this.icon = Icons.folder,
    required this.title,
    required this.subtitle,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: color),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(fontSize: 18, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: color),
          ),
        ],
      ),
    );
  }
}
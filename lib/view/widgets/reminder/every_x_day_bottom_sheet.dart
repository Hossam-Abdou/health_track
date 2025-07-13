import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class EveryXDayBottomSheet extends StatefulWidget {
  const EveryXDayBottomSheet({super.key});

  @override
  State<EveryXDayBottomSheet> createState() => _EveryXDayBottomSheetState();
}

class _EveryXDayBottomSheetState extends State<EveryXDayBottomSheet> {
  int xDay = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Every X days', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*.2,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 50,
              onSelectedItemChanged: (index) {
                setState(() {
                });

              },
              physics: const FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 30,
                builder: (context, index) {
                  return Center(
                    child: Text(
                      '${index + 1} Day',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3b82f6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

}}

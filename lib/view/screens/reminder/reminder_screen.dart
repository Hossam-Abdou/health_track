import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/config/routes.dart';
import 'package:untitled3/view/screens/reminder/reminder_details_screen.dart';
import '../../../view_models/health_cubit.dart';
import '../../../view_models/health_state.dart';
import '../../widgets/reminder/task_header_card.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  void initState() {
    super.initState();
    HealthCubit.get(context).loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3b82f6),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          elevation: 4,
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.reminderDetailsScreen).then((_) {
            HealthCubit.get(context).loadReminders();
          });
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: BlocBuilder<HealthCubit, HealthState>(
          builder: (context, state) {
            final reminders = HealthCubit.get(context).reminders ?? [];
            if (state is ReminderLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } 
            if (reminders.isEmpty) {
              return const Center(child: Text('No reminders yet.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return TaskHeaderCard(
                  medicineName: reminder.name,
                  frequency: reminder.frequency,
                  notificationTimes: reminder.notificationTimes,
                  onEdit: () async {
                    // Navigator.pushNamed(context, Routes.reminderDetailsScreen,
                    // arguments: );
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReminderDetailsScreen(reminder: reminder, index: index),
                      ),
                    );
                    context.read<HealthCubit>().loadReminders();
                  },
                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Reminder'),
                        content: const Text('Are you sure you want to delete this reminder?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await HealthCubit.get(context).deleteReminder(index);
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

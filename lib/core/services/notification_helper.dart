import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import '../../main.dart';
import '../../models/reminder.dart';

class NotificationHelper {
  static Future<void> scheduleReminderNotifications(Reminder reminder, int baseId) async {
    tz.initializeTimeZones();
    final now = DateTime.now();

    for (var i = 0; i < reminder.notificationTimes.length; i++) {
      final time = reminder.notificationTimes[i];

      DateTime scheduledDate = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      try {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          baseId + i, // ✅ Use valid baseId
          'Medication Reminder',
          'It\'s time to take your medication: ${reminder.name}',
          tz.TZDateTime.from(scheduledDate, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'reminder_channel',
              'Reminders',
              channelDescription: 'Reminder notifications for medications',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      } catch (e) {
        debugPrint(e.toString());

    await flutterLocalNotificationsPlugin.show(
          9999,
          'Notification Error',
          e.toString(),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'error_channel',
              'Errors',
              channelDescription: 'Error notifications',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    }
  }

  static Future<void> cancelReminderNotifications(int baseId, int count) async {
    for (var i = 0; i < count; i++) {
      await flutterLocalNotificationsPlugin.cancel(baseId + i);
    }
  }
}

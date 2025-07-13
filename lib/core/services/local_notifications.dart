// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
//
// import '../../models/reminder.dart';
//
// class LocalNotificationsService {
//   static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   // ✅ 1. Initialize
//   static Future<void> initialize(BuildContext context) async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSettings = DarwinInitializationSettings();
//
//     const settings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );
//
//     await _flutterLocalNotificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (response) {
//         final payload = response.payload;
//         debugPrint("Notification tapped: $payload");
//         // Handle navigation or logic here
//       },
//     );
//   }
//
//   // ✅ 2. Convert TimeOfDay → Next DateTime
//   static DateTime _nextInstanceOfTime(TimeOfDay time) {
//     final now = DateTime.now();
//     DateTime scheduledTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//     if (scheduledTime.isBefore(now)) {
//       scheduledTime = scheduledTime.add(const Duration(days: 1));
//     }
//     return scheduledTime;
//   }
//
//   // ✅ 3. Schedule one notification
//   static Future<void> scheduleReminderNotification({
//     required int id,
//     required String title,
//     required String body,
//     required TimeOfDay time,
//   }) async {
//     tz.initializeTimeZones();
//     final scheduledDate = _nextInstanceOfTime(time);
//
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledDate, tz.local),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'reminder_channel',
//           'Reminder Notifications',
//           channelDescription: 'Reminders for medication',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: DarwinNotificationDetails(),
//       ),
//       // androidAllowWhileIdle: true,
//       // uiLocalNotificationDateInterpretation:
//       // UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
//     );
//   }
//
//   // ✅ 4. Schedule all notifications from Reminder model
//   static Future<void> scheduleAllReminderTimes(Reminder reminder, int baseId) async {
//     for (int i = 0; i < reminder.notificationTimes.length; i++) {
//       final time = reminder.notificationTimes[i];
//       await scheduleReminderNotification(
//         id: baseId + i,
//         title: 'Take ${reminder.name}',
//         body: 'It\'s time to take your medication',
//         time: time,
//       );
//     }
//   }
//
//   // ✅ 5. Optional: Cancel all (by id range)
//   static Future<void> cancelAllReminderNotifications(int baseId, int count) async {
//     for (int i = 0; i < count; i++) {
//       await _flutterLocalNotificationsPlugin.cancel(baseId + i);
//     }
//   }
//
// }

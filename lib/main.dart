import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/route_generator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/observer.dart';
import 'models/medical_file.dart';
import 'models/pill.dart';
import 'models/visit.dart';
import 'models/profile.dart';
import 'models/personal_info.dart';
import 'view_models/health_cubit.dart';
import 'config/routes.dart';
import 'models/reminder.dart';
import 'models/time_of_day_adapter.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
   // tz.initializeTimeZones();

  await Hive.initFlutter();
  Hive.registerAdapter(MedicalFileAdapter());
  Hive.registerAdapter(PillAdapter());
  Hive.registerAdapter(VisitAdapter());
  Hive.registerAdapter(ProfileAdapter());
  Hive.registerAdapter(PersonalInfoAdapter());
  Hive.registerAdapter(ReminderAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());


  // Open all boxes concurrently using Future.wait
  await Future.wait([
    Hive.openBox<MedicalFile>('medicalFiles'),
    Hive.openBox<Pill>('pills'),
    Hive.openBox<Visit>('visits'),
    Hive.openBox<Profile>('profile'),
    Hive.openBox<PersonalInfo>('personalInfo'),
    Hive.openBox<Reminder>('reminders'),
  ]);
  try {
    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // Create notification channel for Android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(AndroidNotificationChannel(
          'reminder_channel',
          'Reminders',
          description: 'Reminder notifications for medications',
          importance: Importance.max,
        ));
  } catch (e) {
    // Show a notification if initialization fails
    await flutterLocalNotificationsPlugin.show(
      0,
      'Initialization Error',
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<PersonalInfo>('personalInfo');
    final data = box.get(0);


    return BlocProvider(
      create: (_) => HealthCubit(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: data==null?Routes.signUp:Routes.mainRoute,
            onGenerateRoute: RouteGenerator.getRoute,
          );
        },
      ),
    );
  }
}
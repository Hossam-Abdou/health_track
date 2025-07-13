import 'package:flutter/material.dart';
import 'package:untitled3/view/screens/reminder/reminder_screen.dart';

import 'home_screen.dart';
import 'pills/medication_management_screen.dart';
import 'profile/personal_info_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    ReminderScreen(),
    PersonalInfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalRoute.of(context)?.navigator?.popUntil((route) {
        print('Route in stack: ${route.settings.name}');
        return true;
      });
    });

    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 0) {
          // Go back to Home tab instead of popping the route
          setState(() {
            selectedIndex = 0;
          });
          return false; // Don't pop the route
        }
        return true; // Allow pop (exit the app)
      },
      child: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Reminder'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
} 
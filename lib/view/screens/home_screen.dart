import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/routes.dart';
import '../widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeCard(
                icon: FontAwesomeIcons.pills,
                title: 'Pills',
                subtitle: 'Manage your medications',
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.pillsRoute,
                ),
              ),
              const SizedBox(height: 24),
              HomeCard(
                icon: FontAwesomeIcons.stethoscope,
                title: 'Visits',
                subtitle: 'Track doctor appointments',
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.visitsRoute,
                ),
              ),
              const SizedBox(height: 24),
              HomeCard(
                icon: FontAwesomeIcons.folder,
                title: 'Files',
                subtitle: 'Access your medical records',
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.filesRoute,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

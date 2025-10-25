import 'package:flutter/material.dart';
import 'package:untitled3/view/screens/medical_files/custom_file_viewer.dart';
import 'package:untitled3/view/screens/sign_up.dart';
import '../core/utils/widgets/prescription_image_viewer_screen.dart';
import '../core/utils/widgets/prescription_pdf_viewer_screen.dart';
import '../models/visit.dart';
import '../view/screens/doctor_visit/doctor_visits_screen.dart';
import '../view/screens/pills/medication_management_screen.dart';
import '../view/screens/medical_files/medical_files_screen.dart';
import '../view/screens/profile/personal_info_screen.dart';
import '../view/screens/doctor_visit/visit_details_screen.dart';
import '../view/screens/main_navigation.dart';
import '../config/routes.dart';
import '../view/screens/reminder/reminder_details_screen.dart';
import '../view/screens/reminder/reminder_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainNavigation());

      case Routes.pillsRoute:
        return MaterialPageRoute(
          builder: (_) => const MedicationManagementScreen(),
        );

      case Routes.visitsRoute:
        return MaterialPageRoute(builder: (_) => const DoctorVisitsScreen());

      case Routes.fileViewDetails:
        final args = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (_) => CustomFileViewerScreen(
            filePath: args[0],
            fileName: args[1],
          ),
        );

      case Routes.filesRoute:
        return MaterialPageRoute(builder: (_) => const MedicalFilesScreen());

      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

        case Routes.prescriptionPdfViewerScreen:
        return MaterialPageRoute(builder: (_) =>  PrescriptionPdfViewerScreen(pdfPath: settings.arguments as String,));

        case Routes.prescriptionImageViewerScreen:
        return MaterialPageRoute(builder: (_) =>  PrescriptionImageViewerScreen(imagePath: settings.arguments as String,));

      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const PersonalInfoScreen());

      case Routes.reminderScreen:
        return MaterialPageRoute(builder: (_) => const ReminderScreen());

      case Routes.reminderDetailsScreen:
        return MaterialPageRoute(builder: (_) =>  ReminderDetailsScreen());

      case Routes.visitDetailsRoute:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => VisitDetailsScreen(visit: args as Visit),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute([String? routeName]) {
    // print('Undefined route: $routeName');
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}

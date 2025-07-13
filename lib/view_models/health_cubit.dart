import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../models/pill.dart';
import '../models/visit.dart';
import '../models/medical_file.dart';
import '../models/profile.dart';
import '../models/personal_info.dart';
import '../models/reminder.dart';
import 'health_state.dart';


// Main Health Cubit
class HealthCubit extends Cubit<HealthState> {
  HealthCubit() : super(HealthInitialState()) {
    // loadMedications(); // Load medications by default
  }
  static HealthCubit get(context) => BlocProvider.of(context);

  // Load all data method
  Future<void> loadAllData() async {
    await loadMedications();
    await loadDoctorVisits();
    await loadMedicalFiles();
    // await loadProfile();
    await loadPersonalInfo();
  }
  List<Pill>? pills;
  List<Visit>? visits;
  List<MedicalFile>? files;
  List<Reminder>? reminders;


  // Medication Methods
  Future<void> loadMedications() async {
    emit(MedicationLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Pill>('pills', path: appDocumentsDir.path);
      pills = box.values.toList();
      debugPrint('Medications loaded: ${pills?.length ?? 0}');
      emit(MedicationSuccessState());
    } catch (error) {
      debugPrint('Error loading medications: $error');
      emit(MedicationErrorState(error.toString()));
    }
  }

  Future<void> addMedication(Pill pill) async {
    emit(AddMedicationLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Pill>('pills', path: appDocumentsDir.path);
      await box.add(pill);
      debugPrint('Medication added: ${pill.name}');
      emit(AddMedicationSuccessState());
      await loadMedications(); // Reload medications to update the list
    } catch (error) {
      debugPrint('Error adding medication: $error');
      emit(AddMedicationErrorState(error.toString()));
    }
  }

  Future<void> deleteMedication(int index) async {
    emit(DeleteMedicationLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Pill>('pills', path: appDocumentsDir.path);
      await box.deleteAt(index);
      debugPrint('Medication removed at index: $index');
      emit(DeleteMedicationSuccessState());
      await loadMedications(); // Reload medications to update the list
    } catch (error) {
      debugPrint('Error deleting medication: $error');
      emit(DeleteMedicationErrorState(error.toString()));
    }
  }

  // Doctor Visits Methods
  Future<void> loadDoctorVisits() async {
    emit(DoctorVisitsLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Visit>('visits', path: appDocumentsDir.path);
       visits = box.values.toList();
      debugPrint('Doctor visits loaded: ${visits?.length??0}');
      emit(DoctorVisitsSuccessState());
    } catch (error) {
      debugPrint('Error loading doctor visits: $error');
      emit(DoctorVisitsErrorState(error.toString()));
    }
  }

  Future<void> addDoctorVisit(Visit visit) async {
    emit(AddDoctorVisitLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Visit>('visits', path: appDocumentsDir.path);
      await box.add(visit);
      debugPrint('Doctor visit added: ${visit.doctor}');
      emit(AddDoctorVisitSuccessState());
      loadDoctorVisits(); // Reload visits to update the list
    } catch (error) {
      debugPrint('Error adding doctor visit: $error');
      emit(AddDoctorVisitErrorState(error.toString()));
    }
  }

  Future<void> deleteDoctorVisit(int index) async {
    emit(DeleteDoctorVisitLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Visit>('visits', path: appDocumentsDir.path);
      await box.deleteAt(index);
      debugPrint('Doctor visit removed at index: $index');
      emit(DeleteDoctorVisitSuccessState());
      loadDoctorVisits(); // Reload visits to update the list
    } catch (error) {
      debugPrint('Error deleting doctor visit: $error');
      emit(DeleteDoctorVisitErrorState(error.toString()));
    }
  }

  // Medical Files Methods
  Future<void> loadMedicalFiles() async {
    emit(MedicalFilesLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<MedicalFile>('medicalFiles', path: appDocumentsDir.path);
       files = box.values.toList();
      debugPrint('Medical files loaded: ${files?.length??0}');
      emit(MedicalFilesSuccessState());
    } catch (error) {
      debugPrint('Error loading medical files: $error');
      emit(MedicalFilesErrorState(error.toString()));
    }
  }

  Future<void> addMedicalFile(MedicalFile file) async {
    emit(AddMedicalFileLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<MedicalFile>('medicalFiles', path: appDocumentsDir.path);
      await box.add(file);
      debugPrint('Medical file added: ${file.name}');
      emit(AddMedicalFileSuccessState());
      loadMedicalFiles(); // Reload files to update the list
    } catch (error) {
      debugPrint('Error adding medical file: $error');
      emit(AddMedicalFileErrorState(error.toString()));
    }
  }

  Future<void> deleteMedicalFile(int index) async {
    emit(DeleteMedicalFileLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<MedicalFile>('medicalFiles', path: appDocumentsDir.path);
      await box.deleteAt(index);
      debugPrint('Medical file removed at index: $index');
      emit(DeleteMedicalFileSuccessState());
      loadMedicalFiles(); // Reload files to update the list
    } catch (error) {
      debugPrint('Error deleting medical file: $error');
      emit(DeleteMedicalFileErrorState(error.toString()));
    }
  }

  Profile? profile;
  // Profile Methods
  Future<void> loadProfile() async {
    emit(ProfileLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Profile>('profile', path: appDocumentsDir.path);
      final profiles = box.values.toList();
      if (profiles.isNotEmpty) {
        debugPrint('Profile loaded: ${profiles.first.name}');
        profile = profiles.first; // Store profile in cubit
        emit(ProfileSuccessState(profiles.first));
      } else {
        // Create default profile if none exists
        final defaultProfile = Profile(
          avatarUrl: 'https://via.placeholder.com/150',
          name: 'User Name',
          email: 'user@example.com',
        );
        await addProfile(defaultProfile);
      }
    } catch (error) {
      debugPrint('Error loading profile: $error');
      emit(ProfileErrorState(error.toString()));
    }
  }

  Future<void> addProfile(Profile profile) async {
    emit(AddProfileLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Profile>('profile', path: appDocumentsDir.path);
      await box.clear(); // Clear existing profile
      await box.add(profile);
      debugPrint('Profile added: ${profile.name}');
      this.profile = profile; // Store profile in cubit
      emit(AddProfileSuccessState());
      loadProfile(); // Reload profile to update the state
    } catch (error) {
      debugPrint('Error adding profile: $error');
      emit(AddProfileErrorState(error.toString()));
    }
  }

  Future<void> updateProfile(Profile profile) async {
    emit(UpdateProfileLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Profile>('profile', path: appDocumentsDir.path);
      await box.clear(); // Clear existing profile
      await box.add(profile);
      debugPrint('Profile updated: ${profile.name}');
      this.profile = profile; // Store profile in cubit
      emit(UpdateProfileSuccessState());
      loadProfile(); // Reload profile to update the state
    } catch (error) {
      debugPrint('Error updating profile: $error');
      emit(UpdateProfileErrorState(error.toString()));
    }
  }

  // // Method to ensure profile is loaded (useful for navigation)
  // Future<void> ensureProfileLoaded() async {
  //   if (profile == null) {
  //     await loadProfile();
  //   }
  // }

  // Personal Info Methods
  Future<void> loadPersonalInfo() async {
    emit(PersonalInfoLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<PersonalInfo>('personalInfo', path: appDocumentsDir.path);
      final personalInfos = box.values.toList();
      if (personalInfos.isNotEmpty) {
        debugPrint('Personal info loaded: ${personalInfos.first.name}');
        emit(PersonalInfoSuccessState(personalInfos.first));
      } else {
        // Create default personal info if none exists
        final defaultPersonalInfo = PersonalInfo(
          name: 'User Name',
          dob: '1990-01-01',
          gender: 'Not specified',
          bloodType: 'Not specified',
          diseases: 'None',
          emergencyContactName: 'Emergency Contact',
          emergencyContactPhone: '+1234567890',
        );
        await addPersonalInfo(defaultPersonalInfo);
      }
    } catch (error) {
      debugPrint('Error loading personal info: $error');
      emit(PersonalInfoErrorState(error.toString()));
    }
  }

  Future<void> addPersonalInfo(PersonalInfo personalInfo) async {
    emit(AddPersonalInfoLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<PersonalInfo>('personalInfo', path: appDocumentsDir.path);
      await box.clear(); // Clear existing personal info
      await box.add(personalInfo);
      debugPrint('Personal info added: ${personalInfo.name}');
      emit(AddPersonalInfoSuccessState());
      loadPersonalInfo(); // Reload personal info to update the state
    } catch (error) {
      debugPrint('Error adding personal info: $error');
      emit(AddPersonalInfoErrorState(error.toString()));
    }
  }

  Future<void> updatePersonalInfo(PersonalInfo personalInfo) async {
    emit(UpdatePersonalInfoLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<PersonalInfo>('personalInfo', path: appDocumentsDir.path);
      await box.clear(); // Clear existing personal info
      await box.add(personalInfo);
      debugPrint('Personal info updated: ${personalInfo.name}');
      emit(UpdatePersonalInfoSuccessState());
      loadPersonalInfo(); // Reload personal info to update the state
    } catch (error) {
      debugPrint('Error updating personal info: $error');
      emit(UpdatePersonalInfoErrorState(error.toString()));
    }
  }

// // Utility Methods
// Future<bool> isMedicationExists(String name) async {
//   try {
//     final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
//     var box = await Hive.openBox<Pill>('pills', path: appDocumentsDir.path);
//     return box.values.any((medication) => medication.name == name);
//   } catch (error) {
//     debugPrint('Error checking medication existence: $error');
//     return false;
//   }
// }
//
// Future<bool> isDoctorVisitExists(String doctor, String date) async {
//   try {
//     final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
//     var box = await Hive.openBox<Visit>('visits', path: appDocumentsDir.path);
//     return box.values.any((visit) => visit.doctor == doctor && visit.date == date);
//   } catch (error) {
//     debugPrint('Error checking doctor visit existence: $error');
//     return false;
//   }
// }
//
// Future<bool> isMedicalFileExists(String name) async {
//   try {
//     final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
//     var box = await Hive.openBox<MedicalFile>('medicalFiles', path: appDocumentsDir.path);
//     return box.values.any((file) => file.name == name);
//   } catch (error) {
//     debugPrint('Error checking medical file existence: $error');
//     return false;
//   }
// }

  // Reminder Methods
  Future<void> loadReminders() async {
    emit(ReminderLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Reminder>('reminders', path: appDocumentsDir.path);
      reminders = box.values.toList();
      debugPrint('Reminders loaded: [32m[1m[4m${reminders?.length ?? 0}[0m');
      emit(ReminderSuccessState());
    } catch (error) {
      debugPrint('Error loading reminders: $error');
      emit(ReminderErrorState(error.toString()));
    }
  }

  Future<dynamic> addReminder(Reminder reminder) async {
    emit(AddReminderLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Reminder>('reminders', path: appDocumentsDir.path);
      await box.add(reminder);
      debugPrint('Reminder added: ${reminder.name}');
      emit(AddReminderSuccessState());
      await loadReminders();
    } catch (error) {
      debugPrint('Error adding reminder: $error');
      emit(AddReminderErrorState(error.toString()));
    }
  }

  Future<void> updateReminder(int index, Reminder reminder) async {
    emit(UpdateReminderLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Reminder>('reminders', path: appDocumentsDir.path);
      await box.putAt(index, reminder);
      debugPrint('Reminder updated at index: $index');
      emit(UpdateReminderSuccessState());
      await loadReminders();
    } catch (error) {
      debugPrint('Error updating reminder: $error');
      emit(UpdateReminderErrorState(error.toString()));
    }
  }

  Future<void> deleteReminder(int index) async {
    emit(DeleteReminderLoadingState());
    try {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<Reminder>('reminders', path: appDocumentsDir.path);
      await box.deleteAt(index);
      debugPrint('Reminder deleted at index: $index');
      emit(DeleteReminderSuccessState());
      await loadReminders();
    } catch (error) {
      debugPrint('Error deleting reminder: $error');
      emit(DeleteReminderErrorState(error.toString()));
    }
  }
}
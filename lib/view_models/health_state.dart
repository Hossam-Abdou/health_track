// Base state class
import '../models/medical_file.dart' ;
import '../models/pill.dart';
import '../models/visit.dart';
import '../models/profile.dart';
import '../models/personal_info.dart';

abstract class HealthState {}

// Medication States
class HealthInitialState extends HealthState {}


class MedicationLoadingState extends HealthState {}
class MedicationSuccessState extends HealthState {
  // final List<Pill> pills;
  // MedicationSuccessState(this.pills);
}
class MedicationErrorState extends HealthState {
  final String error;
  MedicationErrorState(this.error);
}

// Doctor Visits States
class DoctorVisitsLoadingState extends HealthState {}
class DoctorVisitsSuccessState extends HealthState {
  // final List<Visit> visits;
  // DoctorVisitsSuccessState(this.visits);
}
class DoctorVisitsErrorState extends HealthState {
  final String error;
  DoctorVisitsErrorState(this.error);
}

// Medical Files States
class MedicalFilesLoadingState extends HealthState {}
class MedicalFilesSuccessState extends HealthState {
  // final List<MedicalFile> files;
  // MedicalFilesSuccessState(this.files);
}
class MedicalFilesErrorState extends HealthState {
  final String error;
  MedicalFilesErrorState(this.error);
}

// Profile States
class ProfileLoadingState extends HealthState {}
class ProfileSuccessState extends HealthState {
  final Profile profile;
  ProfileSuccessState(this.profile);
}
class ProfileErrorState extends HealthState {
  final String error;
  ProfileErrorState(this.error);
}

// Personal Info States
class PersonalInfoLoadingState extends HealthState {}
class PersonalInfoSuccessState extends HealthState {
  final PersonalInfo personalInfo;
  PersonalInfoSuccessState(this.personalInfo);
}
class PersonalInfoErrorState extends HealthState {
  final String error;
  PersonalInfoErrorState(this.error);
}

// Add/Delete States
class AddMedicationLoadingState extends HealthState {}
class AddMedicationSuccessState extends HealthState {}
class AddMedicationErrorState extends HealthState {
  final String error;
  AddMedicationErrorState(this.error);
}

class DeleteMedicationLoadingState extends HealthState {}
class DeleteMedicationSuccessState extends HealthState {}
class DeleteMedicationErrorState extends HealthState {
  final String error;
  DeleteMedicationErrorState(this.error);
}

class AddDoctorVisitLoadingState extends HealthState {}
class AddDoctorVisitSuccessState extends HealthState {}
class AddDoctorVisitErrorState extends HealthState {
  final String error;
  AddDoctorVisitErrorState(this.error);
}

class DeleteDoctorVisitLoadingState extends HealthState {}
class DeleteDoctorVisitSuccessState extends HealthState {}
class DeleteDoctorVisitErrorState extends HealthState {
  final String error;
  DeleteDoctorVisitErrorState(this.error);
}

class AddMedicalFileLoadingState extends HealthState {}
class AddMedicalFileSuccessState extends HealthState {}
class AddMedicalFileErrorState extends HealthState {
  final String error;
  AddMedicalFileErrorState(this.error);
}

class DeleteMedicalFileLoadingState extends HealthState {}
class DeleteMedicalFileSuccessState extends HealthState {}
class DeleteMedicalFileErrorState extends HealthState {
  final String error;
  DeleteMedicalFileErrorState(this.error);
}

// Profile Add/Update States
class AddProfileLoadingState extends HealthState {}
class AddProfileSuccessState extends HealthState {}
class AddProfileErrorState extends HealthState {
  final String error;
  AddProfileErrorState(this.error);
}

class UpdateProfileLoadingState extends HealthState {}
class UpdateProfileSuccessState extends HealthState {}
class UpdateProfileErrorState extends HealthState {
  final String error;
  UpdateProfileErrorState(this.error);
}

// Personal Info Add/Update States
class AddPersonalInfoLoadingState extends HealthState {}
class AddPersonalInfoSuccessState extends HealthState {}
class AddPersonalInfoErrorState extends HealthState {
  final String error;
  AddPersonalInfoErrorState(this.error);
}

class UpdatePersonalInfoLoadingState extends HealthState {}
class UpdatePersonalInfoSuccessState extends HealthState {}
class UpdatePersonalInfoErrorState extends HealthState {
  final String error;
  UpdatePersonalInfoErrorState(this.error);
}

// Reminder States
class ReminderLoadingState extends HealthState {}
class ReminderSuccessState extends HealthState {}
class ReminderErrorState extends HealthState {
  final String error;
  ReminderErrorState(this.error);
}
class AddReminderLoadingState extends HealthState {}
class AddReminderSuccessState extends HealthState {}
class AddReminderErrorState extends HealthState {
  final String error;
  AddReminderErrorState(this.error);
}
class UpdateReminderLoadingState extends HealthState {}
class UpdateReminderSuccessState extends HealthState {}
class UpdateReminderErrorState extends HealthState {
  final String error;
  UpdateReminderErrorState(this.error);
}
class DeleteReminderLoadingState extends HealthState {}
class DeleteReminderSuccessState extends HealthState {}
class DeleteReminderErrorState extends HealthState {
  final String error;
  DeleteReminderErrorState(this.error);
}
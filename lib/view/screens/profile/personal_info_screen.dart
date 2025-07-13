import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/personal_info.dart';
import '../../../view_models/health_cubit.dart';
import '../../../view_models/health_state.dart';
import '../../widgets/custom_personal_info_fields.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;
  late TextEditingController _bloodTypeController;
  late TextEditingController _diseasesController;
  late TextEditingController _emergencyContactNameController;
  late TextEditingController _emergencyContactPhoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dobController = TextEditingController();
    _genderController = TextEditingController();
    _bloodTypeController = TextEditingController();
    _diseasesController = TextEditingController();
    _emergencyContactNameController = TextEditingController();
    _emergencyContactPhoneController = TextEditingController();

    // Load personal info when screen is first accessed
    context.read<HealthCubit>().loadPersonalInfo();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _bloodTypeController.dispose();
    _diseasesController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactPhoneController.dispose();
    super.dispose();
  }

  void _updateControllers(PersonalInfo personalInfo) {
    _nameController.text = personalInfo.name;
    _dobController.text = personalInfo.dob;
    _genderController.text = personalInfo.gender;
    _bloodTypeController.text = personalInfo.bloodType;
    _diseasesController.text = personalInfo.diseases;
    _emergencyContactNameController.text = personalInfo.emergencyContactName;
    _emergencyContactPhoneController.text = personalInfo.emergencyContactPhone;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HealthCubit, HealthState>(
      listener: (context, state) {
        if (state is AddPersonalInfoErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Error adding personal info: ${state.error}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is UpdatePersonalInfoErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Error updating personal info: ${state.error}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is PersonalInfoErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Error loading personal info: ${state.error}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is UpdatePersonalInfoSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Personal info updated successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: BlocBuilder<HealthCubit, HealthState>(
        builder: (context, state) {
          if (state is PersonalInfoLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is PersonalInfoSuccessState) {
            // Update controllers with current data
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _updateControllers(state.personalInfo);
            });

            return Scaffold(
              appBar: AppBar(
                title: const Text('Personal Info'),
                centerTitle: true,
                automaticallyImplyLeading: false,
                // This removes the back arrow
                elevation: 0,
                scrolledUnderElevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 8),
                      CustomPersonalInfoFields(
                        controller: _nameController,
                        labelText: 'Name',
                      ),
                      CustomPersonalInfoFields(
                        controller: _dobController,
                        labelText: 'Date of Birth',
                        suffixIcon: Icon(Icons.calendar_today),
                        onTap: () {
                          selectDate(context);
                        },
                        isRead: true,
                      ),
                      CustomPersonalInfoFields(
                        controller: _genderController,
                        labelText: 'Gender',
                      ),
                      CustomPersonalInfoFields(
                        controller: _bloodTypeController,
                        labelText: 'Blood Type',
                      ),
                      CustomPersonalInfoFields(
                        controller: _diseasesController,
                        labelText: 'Diseases',
                        hintText: 'Enter "None" if no diseases',
                      ),
                      CustomPersonalInfoFields(
                        controller: _emergencyContactNameController,
                        labelText: 'Emergency Contact Name',
                      ),
                      CustomPersonalInfoFields(
                        controller: _emergencyContactPhoneController,
                        labelText: 'Emergency Contact Phone',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final updatedPersonalInfo = PersonalInfo(
                              name: _nameController.text,
                              dob: _dobController.text,
                              gender: _genderController.text,
                              bloodType: _bloodTypeController.text,
                              diseases: _diseasesController.text,
                              emergencyContactName:
                                  _emergencyContactNameController.text,
                              emergencyContactPhone:
                                  _emergencyContactPhoneController.text,
                            );
                            context.read<HealthCubit>().updatePersonalInfo(
                              updatedPersonalInfo,
                            );
                          }
                        },
                        child: const Text('Save Changes'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: Text('Something went wrong')),
            );
          }
        },
      ),
    );
  }
}

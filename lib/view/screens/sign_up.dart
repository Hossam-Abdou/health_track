import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/config/routes.dart';
import '../../../models/personal_info.dart';
import '../../../view_models/health_cubit.dart';
import '../../../view_models/health_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _selectedBloodType;
  String _selectedGender = 'male';

  final List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final personalInfo = PersonalInfo(
        name: _nameController.text.trim(),
        // phoneNumber: _phoneController.text.trim(),
        gender: _selectedGender,
        bloodType: _selectedBloodType ?? '',
        dob: _dobController.text.trim(),
        diseases: '',
        emergencyContactName: '',
        emergencyContactPhone: '',
      );

      HealthCubit.get(context).addPersonalInfo(personalInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<HealthCubit, HealthState>(
        listener: (context, state) {
          if (state is AddPersonalInfoSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Personal info saved')),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.mainRoute,
                  (route) => false,
            );
          } else if (state is AddPersonalInfoErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (val) => val == null || val.isEmpty ? 'Enter your name' : null,
                  ),
                  // const SizedBox(height: 16),
                  // TextFormField(
                  //   controller: _phoneController,
                  //   decoration: const InputDecoration(labelText: 'Phone'),
                  //   keyboardType: TextInputType.phone,
                  //   validator: (val) => val == null || val.isEmpty ? 'Enter your phone' : null,
                  // ),
                  const SizedBox(height: 16),
                  // TextFormField(
                  //   controller: _dobController,
                  //   decoration: const InputDecoration(labelText: 'Date of Birth'),
                  // ),
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(labelText: 'Date of Birth'),
                    readOnly: true,
                    onTap: () => selectDate(context),
                    validator: (val) => val == null || val.isEmpty ? 'Select your date of birth' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedBloodType,
                    hint: const Text('Select Blood Type'),
                    items: bloodTypes
                        .map((bt) => DropdownMenuItem(value: bt, child: Text(bt)))
                        .toList(),
                    onChanged: (value) => setState(() => _selectedBloodType = value),
                    validator: (val) => val == null ? 'Select blood type' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Gender:', style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'male',
                            groupValue: _selectedGender,
                            onChanged: (value) => setState(() => _selectedGender = value!),
                          ),
                          const Text('Male'),
                          const SizedBox(width: 16),
                          Radio<String>(
                            value: 'female',
                            groupValue: _selectedGender,
                            onChanged: (value) => setState(() => _selectedGender = value!),
                          ),
                          const Text('Female'),
                        ],
                      ),
                    ],
                  ),                  const SizedBox(height: 24),
                  state is AddPersonalInfoLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/visit.dart';
import '../../../view_models/health_cubit.dart';

class AddDoctorVisitBottomSheet extends StatefulWidget {
  const AddDoctorVisitBottomSheet({super.key});

  @override
  State<AddDoctorVisitBottomSheet> createState() => _AddDoctorVisitBottomSheetState();
}

class _AddDoctorVisitBottomSheetState extends State<AddDoctorVisitBottomSheet> {
  final doctorController = TextEditingController();
  final reasonController = TextEditingController();
  final notesController = TextEditingController();
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? selectedPrescriptionPath;
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Container(
          padding:  EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add New Doctor Visit',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: doctorController,
                    decoration: const InputDecoration(
                      labelText: 'Doctor Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,

                  ),
                  const SizedBox(height: 16),
                  // Date Picker
                  InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = DateFormat('yyyy-MM-dd').format(picked);
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date: $selectedDate',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: reasonController,
                    decoration: const InputDecoration(
                      labelText: 'Reason for Visit',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,

                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Notes (Optional)',
                      border: OutlineInputBorder(),
                    ),

                  ),
                  const SizedBox(height: 16),
                  // Prescription Image/PDF Selection
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
                            );
                            if (result != null) {
                              setState(() {
                                selectedPrescriptionPath = result.files.single.path;
                              });
                            }
                          },
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Add Prescription'),
                        ),
                      ),
                    ],
                  ),

                  if (selectedPrescriptionPath != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            selectedPrescriptionPath!.toLowerCase().endsWith('.pdf')
                                ? Icons.picture_as_pdf
                                : Icons.image,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selectedPrescriptionPath!.split('/').last,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {


                        if (formKey.currentState!.validate()) {
                          final visit = Visit(
                            doctor: doctorController.text,
                            date: selectedDate,
                            reason: reasonController.text,
                            iconCodePoint: Icons.medical_services.codePoint,
                            prescriptionImagePath: selectedPrescriptionPath,
                            notes: notesController.text.isNotEmpty
                                ? notesController.text
                                : null,
                          );

                          await BlocProvider.of<HealthCubit>(context).addDoctorVisit(visit);
                          Navigator.pop(context);

                        }
                        // if (doctorController.text.isNotEmpty &&
                        //     reasonController.text.isNotEmpty) {
                        //   try {
                        //
                        //
                        //
                        //   } catch (e) {
                        //     Navigator.pop(context);
                        //
                        //   }
                        // }
                      },
                      child: const Text('Add Visit'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

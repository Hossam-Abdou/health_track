import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/core/constants/app_colors.dart';
import '../../../core/utils/widgets/custom_snack_bar.dart';
import '../../../models/medical_file.dart';
import '../../../view_models/health_cubit.dart';
import '../../../view_models/health_state.dart';
import '../../../core/utils/widgets/empty_files.dart';
import '../../widgets/medical_files/add_medical_file_bottom_sheet.dart';
import '../../widgets/medical_files/medical_file_list_tile.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class MedicalFilesScreen extends StatefulWidget {
  const MedicalFilesScreen({Key? key}) : super(key: key);

  @override
  State<MedicalFilesScreen> createState() => _MedicalFilesScreenState();
}

class _MedicalFilesScreenState extends State<MedicalFilesScreen> {

  @override
  void initState() {
    super.initState();
    context.read<HealthCubit>().loadMedicalFiles();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HealthCubit, HealthState>(
      listener: (context, state) {
        if (state is AddMedicalFileSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(message: 'Added Successfully',).customSnackBar()
          );

        }

        else if (state is MedicalFilesErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(message: '❌ Error loading medical files: ${state.error}',
              color: Colors.red
              ).customSnackBar()
          );

        }
      },
      child: BlocBuilder<HealthCubit, HealthState>(
        builder: (context, state) {
          var cubit = context.read<HealthCubit>();
          if (state is MedicalFilesLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          else if (state is MedicalFilesSuccessState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Medical Files'),
                centerTitle: true,
              ),
              body: cubit.files?.isEmpty??true
                  ? const EmptyFiles(
                title:'No medical files added yet',
                subtitle:'Tap the + button to add your first medical file',
                icon: Icons.folder,
              )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: cubit.files?.length??0,
                      itemBuilder: (context, index) {
                        final file = cubit.files![index];
                        return MedicalFileListTile(
                          file: file,
                          onDelete: () => context.read<HealthCubit>().deleteMedicalFile(index),
                        );
                      },
                    ),
              floatingActionButton: FloatingActionButton(
                mini: true,

                onPressed: () =>showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddMedicalFilesBottomSheet(),
                ),
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            );
          } else { 
            return const Scaffold(
              body: Center(
                child: Text('Something went wrong'),
              ),
            );
          }
        },
      ),
    );
  }
} 
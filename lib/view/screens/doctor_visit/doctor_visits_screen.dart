import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/config/routes.dart';
import 'package:untitled3/view/widgets/doctor_visit/add_doctor_visit_bottom_sheet.dart';
import 'package:untitled3/view/widgets/doctor_visit/visit_list_tile.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/widgets/custom_snack_bar.dart';
import '../../../core/utils/widgets/empty_files.dart';
import '../../../view_models/health_cubit.dart';
import '../../../view_models/health_state.dart';

class DoctorVisitsScreen extends StatefulWidget {
  const DoctorVisitsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorVisitsScreen> createState() => _DoctorVisitsScreenState();
}

class _DoctorVisitsScreenState extends State<DoctorVisitsScreen> {
  void _showAddVisitBottomSheet(BuildContext context) {


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddDoctorVisitBottomSheet(),
    );
  }

  @override
  void initState() {
    super.initState();
    // Load doctor visits when screen is first accessed
    context.read<HealthCubit>().loadDoctorVisits();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HealthCubit, HealthState>(
      listener: (context, state) {

        if (state is AddDoctorVisitSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(message: 'Added Successfully',).customSnackBar()
          );

        }
        else if (state is DeleteDoctorVisitErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Error deleting doctor visit: ${state.error}'),
              backgroundColor: AppColors.error,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: BlocBuilder<HealthCubit, HealthState>(
        builder: (context, state) {
          var cubit = context.read<HealthCubit>();
          if (state is DoctorVisitsLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is DoctorVisitsSuccessState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Doctor Visits'),
                centerTitle: true,
              ),
              body: cubit.visits?.isEmpty??true
                  ?  const EmptyFiles(
                title:'No doctor visits added yet',
                subtitle:'Tap the + button to add your first visit',
                icon: Icons.medical_services,
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cubit.visits?.length??0,
                itemBuilder: (context, index) {
                  final visit = cubit.visits![index];
                  return VisitListTile(
                    visit: visit,
                    onDelete: () => context.read<HealthCubit>().deleteDoctorVisit(index),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.visitDetailsRoute,
                        arguments: visit,
                      );
                    },
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                mini: true,
                onPressed: () => _showAddVisitBottomSheet(context),
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
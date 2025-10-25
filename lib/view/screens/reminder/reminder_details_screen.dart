import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/notification_helper.dart';
import '../../../core/utils/widgets/time_picker_bottom_sheet.dart';
import '../../../view_models/health_cubit.dart';
import '../../../models/reminder.dart';

class ReminderDetailsScreen extends StatefulWidget {
  final Reminder? reminder;
  final int? index;
  const ReminderDetailsScreen({super.key, this.reminder, this.index});

  @override
  State<ReminderDetailsScreen> createState() => _RegisterMedicationScreenState();
}

class _RegisterMedicationScreenState extends State<ReminderDetailsScreen> {
  final List<String> frequencyOptions = ['Everyday'];
  String selectedOption = 'Everyday';
  final List<TimeOfDay> times = [];
  bool isNotificationOpen = true;
  int selectedXDay = 1;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.reminder != null) {
      _nameController.text = widget.reminder!.name;
      times.addAll(widget.reminder!.notificationTimes);
      isNotificationOpen = widget.reminder!.notificationOn;
      selectedOption = widget.reminder!.frequency;
    } else {
      times.addAll([
        const TimeOfDay(hour: 7, minute: 0),
        const TimeOfDay(hour: 13, minute: 0),
        const TimeOfDay(hour: 17, minute: 0),
      ]);
    }
  }
  // Future<void> requestExactAlarmsPermission() async {
  //   if (!Platform.isAndroid) return;
  //
  //   try {
  //     final androidInfo = await DeviceInfoPlugin().androidInfo;
  //     if (androidInfo.version.sdkInt >= 31) {
  //       final intent = AndroidIntent(
  //         action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
  //       );
  //
  //       // Try launching the intent safely
  //       await intent.launch();
  //     }
  //   } on PlatformException catch (e) {
  //     debugPrint('Cannot open exact alarm permission screen: ${e.message}');
  //   } catch (e) {
  //     debugPrint('Error requesting exact alarm permission: $e');
  //   }
  // }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medication Name',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameController,
                  decoration: _inputDecoration(),
                  style: const TextStyle(color: Colors.black87),
                ),

                // const SizedBox(height: 16),
                // Text(
                //   'Frequency',
                //   style: TextStyle(
                //     color: AppColors.secondary,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: _boxDecoration(),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedOption,
                      isExpanded: true,
                      iconEnabledColor: AppColors.secondary,
                      items: frequencyOptions
                          .map(
                            (val) => DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                val,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });

                        // if (value == 'Days') {
                        //
                        //   _showDaysOfWeekModal();
                        // } else if (value == 'Every X Day') {
                        //   _showEveryXDaysModal();
                        // }
                      },
                    ),
                  ),
                ),
                // if (selectedOption == 'Every X Day')
                //   Padding(
                //     padding: const EdgeInsets.only(top: 12.0),
                //     child: GestureDetector(
                //       onTap: () {
                //         _showEveryXDaysModal(); // opens the day picker
                //       },
                //       child: Container(
                //         width: double.infinity,
                //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                //         decoration: _boxDecoration(),
                //         child: Text(
                //           'Every $selectedXDay day${selectedXDay > 1 ? "s" : ""}',
                //           style: const TextStyle(color: Colors.black87, fontSize: 16),
                //         ),
                //       ),
                //     ),
                //   ),

                const SizedBox(height: 24),
                Text(
                  'Notification Time',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: _boxDecoration(),
                  child: Column(
                    children: times.map((time) {
                      return ListTile(
                        title: Text(
                          time.format(context),
                          style: const TextStyle(color: Colors.black87),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Color(0xFF3b82f6),
                          ),
                          onPressed: () {
                            setState(() {
                              times.remove(time);
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3b82f6),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        backgroundColor: const Color(0xFF1C1C1E),
                        builder: (BuildContext context) {
                          return TimePickerBottomSheet(
                            onTimeSelected: (TimeOfDay time) {
                              setState(() {
                                times.add(time); // Add to your list
                              });
                            },
                          );
                        },
                      );
                      // openTimePickerDialog();
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Notification',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: _boxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('ON', style: TextStyle(color: Colors.black87)),
                      Switch(
                        value: isNotificationOpen,
                        activeColor: AppColors.secondary,
                        onChanged: (_) {
                          setState(() {});
                          isNotificationOpen = !isNotificationOpen;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3b82f6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                    ),
                    onPressed: () async {
                      final name = _nameController.text.trim();
                      if (name.isEmpty || times.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter all fields.')),
                        );
                        return;
                      }
                      final reminder = Reminder(
                        name: name,
                        notificationTimes: List<TimeOfDay>.from(times),
                        notificationOn: isNotificationOpen,
                        frequency: selectedOption,
                      );
                      if (widget.reminder != null && widget.index != null) {
                        await HealthCubit.get(context).updateReminder(widget.index!, reminder);

                        if (reminder.notificationOn) {
                          await NotificationHelper.scheduleReminderNotifications(reminder, widget.index!);
                          // await requestExactAlarmsPermission();

                        }
                      } else {
                        int? baseId = await HealthCubit.get(context).addReminder(reminder);

                        baseId ??= DateTime.now().millisecondsSinceEpoch.remainder(100000);
                        // print('baseId:$baseId');
                        // print('notifican on/off ${reminder.notificationOn}');

                        if (baseId != null && reminder.notificationOn) {
                          await NotificationHelper.scheduleReminderNotifications(reminder, baseId);
                        }
                      }

                      Navigator.pop(context);
                    },
                    child: Text(
                      widget.reminder != null ? 'Update' : 'Save',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],

            ),
          ),
        ),
      ),
    );

  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: 'medicine name',
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.secondary),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.secondary, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFF3b82f6)),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    );
  }


}

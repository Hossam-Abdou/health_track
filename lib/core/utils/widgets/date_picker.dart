// abstract class TimePicker{
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
//       });
//     }
//   }
//
// }
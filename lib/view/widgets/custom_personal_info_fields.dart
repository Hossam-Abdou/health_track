import 'package:flutter/material.dart';

class CustomPersonalInfoFields extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool isRead;

  const CustomPersonalInfoFields({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.onTap,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.isRead=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          readOnly: isRead,
          onTap: onTap,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            suffixIcon: suffixIcon,
            border: const OutlineInputBorder(),
          ),
          validator: validator ?? (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $labelText';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
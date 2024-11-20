import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {super.key,
      required this.hint,
      required this.controller,
      this.isObscureText = false});
  final String hint;
  final TextEditingController controller;
  final bool isObscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hint is missing";
        }
        return null;
      },
    );
  }
}

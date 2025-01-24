import 'package:flutter/material.dart';
import 'package:task_management_test/core/utils/string_validator.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword;
  final ValidationType validationType;
  final String label;
  final String hint;
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.validationType,
    required this.label,
    required this.hint,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && !showPassword,
      validator: (value) {
        if (value!.isEmpty &&
            widget.validationType != ValidationType.notRequired) {
          return 'This field is required';
        }
        if (widget.validationType == ValidationType.email) {
          if (!value.isValidEmail) {
            return 'Please enter a valid email';
          }
        }
        if (widget.validationType == ValidationType.password) {
          if (!value.isValidPassword) {
            return 'Password Must be more than 5 Characters Alpha Numeric & Symbols';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        border: OutlineInputBorder(),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  showPassword = !showPassword;
                  setState(() {});
                },
                icon: Icon(
                  showPassword ? Icons.remove_red_eye : Icons.visibility_off,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );
  }
}

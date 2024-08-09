import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required TextEditingController passwordController,
    required this.hintText,
    required this.validationRegExp,
    this.obscureText = false,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;
  final String hintText;
  final RegExp validationRegExp;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value != null && validationRegExp.hasMatch(value)) {
          return null;
        }
        return "Используйте корректный ${hintText.toLowerCase()}";
      },
    );
  }
}

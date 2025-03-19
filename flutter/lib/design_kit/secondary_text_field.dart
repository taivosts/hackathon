import 'package:flutter/material.dart';
import 'package:ai_dreamer/design_kit/design_kit.dart';

class SecondaryTextField extends StatelessWidget {
  const SecondaryTextField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.obscureText = false,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintStyle: AppFont.input(color: Colors.black.withValues(alpha: 0.26)),
          labelStyle: AppFont.input(),
        ),
        obscureText: obscureText,
      ),
    );
  }
}

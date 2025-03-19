import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ai_dreamer/design_kit/text_style.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isRequired = true,
    this.suffixIcon,
    this.readOnly = false,
    this.keyboardType,
    this.textCapitalization,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.errorText,
    this.validator,
    this.inputLine = 1,
    this.onTap,
    this.maxLength,
    this.obscureText = false,
  });

  final String label;
  final String hintText;
  final bool isRequired;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final String? Function(String?)? validator;
  final int? inputLine;
  final VoidCallback? onTap;
  final int? maxLength;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelStyle: AppFont.caption(color: Colors.black),
        hintText: hintText,
        hintStyle: AppFont.b1(color: const Color(0xFFBDBDBD)),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            const SizedBox(width: 4),
            Visibility(
              visible: isRequired,
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child:
                    Text('*', style: AppFont.caption(color: AppColors.error)),
              ),
            ),
          ],
        ),
        floatingLabelStyle: AppFont.caption(color: const Color(0xFF026BFE)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: Color(0xFF026BFE),
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.0,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: suffixIcon,
        errorText: errorText,
        errorMaxLines: 2,
        errorStyle: AppFont.caption(color: AppColors.error),
      ),
      readOnly: readOnly,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      validator: validator,
      maxLines: inputLine == 1 ? 1 : null,
      minLines: inputLine == 1 ? null : inputLine,
      maxLength: maxLength,
      obscureText: obscureText,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ai_dreamer/design_kit/text_style.dart';

class PrimaryPasswordTextField extends StatefulWidget {
  const PrimaryPasswordTextField({super.key});

  @override
  State<PrimaryPasswordTextField> createState() =>
      _PrimaryPasswordTextFieldState();
}

class _PrimaryPasswordTextFieldState extends State<PrimaryPasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextField(
        obscureText: _obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset('assets/icons/ic_lock.svg'),
          ),
          suffixIcon: GestureDetector(
            onTap: () => setState(() {
              _obscureText = !_obscureText;
            }),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(
                'assets/icons/ic_eye_open.svg',
              ),
            ),
          ),
          hintText: 'Mật khẩu',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintStyle: AppFont.input(color: Colors.black.withOpacity(0.26)),
          labelStyle: AppFont.input(),
        ),
      ),
    );
  }
}

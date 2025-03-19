import 'package:ai_dreamer/design_kit/text_style.dart';
import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class AppVersionBar extends StatelessWidget {
  const AppVersionBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 32,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE1238E),
            Color(0xFFE1238E),
            Color(0xFF29005A),
            Color(0xFF29005A),
          ],
        ),
      ),
      child: Center(
        child: Text(
          'Version 1.0',
          style: AppFont.b1(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

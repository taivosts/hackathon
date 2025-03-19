import 'package:flutter/material.dart';
import 'package:ai_dreamer/design_kit/design_kit.dart';

class BaseTag extends StatelessWidget {
  const BaseTag({
    super.key,
    required this.title,
    this.backgroundColor = const Color(0xFF0558EE),
    this.textColor = Colors.white,
  });

  final String title;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: AppFont.inputSmall(color: textColor),
      ),
    );
  }
}

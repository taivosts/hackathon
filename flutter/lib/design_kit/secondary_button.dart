import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';

enum SecondaryButtonStyle { normal, small, remove }

extension SecondaryButtonStyleExt on SecondaryButtonStyle {
  Color get enableColor {
    switch (this) {
      case SecondaryButtonStyle.normal:
      case SecondaryButtonStyle.small:
        return AppColors.accent;
      case SecondaryButtonStyle.remove:
        return AppColors.error;
    }
  }

  double get height {
    switch (this) {
      case SecondaryButtonStyle.normal:
        return 48;
      case SecondaryButtonStyle.small:
      case SecondaryButtonStyle.remove:
        return 28;
    }
  }

  TextStyle get style {
    switch (this) {
      case SecondaryButtonStyle.normal:
        return AppFont.button();
      case SecondaryButtonStyle.small:
      case SecondaryButtonStyle.remove:
        return AppFont.caption();
    }
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.title,
    this.enable = true,
    this.onTap,
    this.style = SecondaryButtonStyle.normal,
  });

  final String title;
  final bool enable;
  final VoidCallback? onTap;
  final SecondaryButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: style.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: style.enableColor),
        ),
        child: Center(
          child: Text(
            title,
            style: style.style.copyWith(
              color: enable ? style.enableColor : Colors.black26,
            ),
          ),
        ),
      ),
    );
  }
}

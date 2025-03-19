import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum PrimaryButtonStyle { normal, small }

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.enable = true,
    this.onTap,
    this.iconPath,
    this.style = PrimaryButtonStyle.normal,
    this.backgroundColor = AppColors.accent,
  });

  final String title;
  final bool enable;
  final VoidCallback? onTap;
  final String? iconPath;
  final PrimaryButtonStyle style;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable ? onTap : null,
      child: Container(
        height: style == PrimaryButtonStyle.normal ? 48 : 24,
        decoration: BoxDecoration(
            color: enable ? backgroundColor : AppColors.disable,
            borderRadius: BorderRadius.circular(36)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SvgPicture.asset(iconPath!),
              ),
            Text(
              title,
              style: style == PrimaryButtonStyle.normal
                  ? AppFont.button(
                      color: enable ? Colors.white : Colors.black26)
                  : AppFont.caption(
                      color: enable ? Colors.white : Colors.black26),
            ),
          ],
        ),
      ),
    );
  }
}

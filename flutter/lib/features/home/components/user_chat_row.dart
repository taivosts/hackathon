import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';

class UserChatRow extends StatelessWidget {
  const UserChatRow({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth * 0.8,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              border: Border.all(
                color: AppColors.gray5,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              message,
              style: AppFont.b1(),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}

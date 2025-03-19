import 'package:ai_dreamer/design_kit/text_style.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BotChatRow extends StatelessWidget {
  const BotChatRow({
    super.key,
    required this.message,
    required this.sources,
  });

  final String message;
  final List<String> sources;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Markdown(
          data: message,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
        if (sources.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.only(top: 16, left: 8),
            height: 1,
            color: AppColors.gray5,
            width: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              sources.toSet().join('\n'),
              style: AppFont.helperText().copyWith(color: AppColors.gray4),
            ),
          ),
        ],
      ],
    );
  }
}

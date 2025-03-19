import 'package:ai_dreamer/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    this.onSend,
  });

  final VoidCallback? onSend;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final message = _controller.text;
    if (message.isNotEmpty) {
      context.read<HomeBloc>().add(MessageSent(message));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray5),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: AppColors.primary,
                  selectionColor: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'How can I help you?',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: AppFont.input(
                      color: Colors.black.withValues(alpha: 0.26)),
                  labelStyle: AppFont.input(),
                ),
                maxLines: 4,
                minLines: 1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                _sendMessage();
                widget.onSend?.call();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.send,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

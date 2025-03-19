import 'dart:math';
import 'package:ai_dreamer/design_kit/text_style.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class AmountInput extends StatefulWidget {
  const AmountInput({
    super.key,
    required this.title,
    this.initialValue = 0,
    this.onChanged,
  });

  final String title;
  final int initialValue;
  final Function(int)? onChanged;

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController =
        TextEditingController(text: widget.initialValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppFont.caption(color: AppColors.info),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                final newNumber =
                    max(0, (int.tryParse(textEditingController.text) ?? 0) - 1);
                textEditingController.text = "$newNumber";
                widget.onChanged?.call(newNumber);
              },
              child: SvgPicture.asset('assets/icons/ic_step_arrow_left.svg'),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 32,
              height: 32,
              child: TextFormField(
                controller: textEditingController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: AppColors.greyLighten2,
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
                  contentPadding: EdgeInsets.zero,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onEditingComplete: () {
                  final newNumber =
                      int.tryParse(textEditingController.text) ?? 0;
                  widget.onChanged?.call(newNumber);
                },
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                final newNumber =
                    (int.tryParse(textEditingController.text) ?? 0) + 1;
                textEditingController.text = "$newNumber";
                widget.onChanged?.call(newNumber);
              },
              child: SvgPicture.asset('assets/icons/ic_step_arrow_right.svg'),
            ),
          ],
        ),
      ],
    );
  }
}

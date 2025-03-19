import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryCheckbox extends StatefulWidget {
  const PrimaryCheckbox({
    super.key,
    this.title,
    this.titleWidget,
    this.onChanged,
  });

  final String? title;
  final Widget? titleWidget;
  final Function(bool)? onChanged;

  @override
  State<PrimaryCheckbox> createState() => _PrimaryCheckboxState();
}

class _PrimaryCheckboxState extends State<PrimaryCheckbox> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(!isSelected);
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset('assets/icons/ic_checkbox_unchecked.svg'),
              Visibility(
                visible: isSelected,
                child: Container(
                  width: 10,
                  height: 10,
                  color: AppColors.accent,
                ),
              )
            ],
          ),
          const SizedBox(width: 12),
          if (widget.title != null)
            Expanded(
              child: Text(
                widget.title!,
                style: AppFont.b1(),
              ),
            ),
          if (widget.titleWidget != null) Expanded(child: widget.titleWidget!)
        ],
      ),
    );
  }
}

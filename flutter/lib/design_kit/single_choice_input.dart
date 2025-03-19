import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class SingleChoosable {
  String get title;
}

class SingleChoiceInput extends StatefulWidget {
  const SingleChoiceInput({
    super.key,
    required this.title,
    required this.values,
    this.onChanged,
    this.backgroundColor = Colors.white,
  });

  final String title;
  final List<SingleChoosable> values;
  final Function(SingleChoosable)? onChanged;
  final Color backgroundColor;

  @override
  State<SingleChoiceInput> createState() => _SingleChoiceInputState();
}

class _SingleChoiceInputState extends State<SingleChoiceInput> {
  SingleChoosable? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: const [
          BoxShadow(color: Colors.black12, offset: Offset(0, 1), blurRadius: 2)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppFont.subtitle1(color: AppColors.info),
          ),
          const SizedBox(height: 16),
          Column(
            children: widget.values
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedItem = e;

                        widget.onChanged?.call(e);
                      });
                    },
                    child: _SingleChoiceItem(
                      e.title,
                      isSelected: selectedItem == e,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SingleChoiceItem extends StatelessWidget {
  const _SingleChoiceItem(this.title, {this.isSelected = false});
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset('assets/icons/ic_radio_unchecked.svg'),
              if (isSelected)
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                )
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppFont.button(color: Colors.black),
        ),
      ],
    );
  }
}

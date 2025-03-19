import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MultipleChoicesInlineInput extends StatefulWidget {
  const MultipleChoicesInlineInput({
    super.key,
    required this.values,
    this.onChanged,
  });

  final List<String> values;
  final Function(String)? onChanged;

  @override
  State<MultipleChoicesInlineInput> createState() =>
      _MultipleChoicesInlineInputState();
}

class _MultipleChoicesInlineInputState
    extends State<MultipleChoicesInlineInput> {
  List<String> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.values
          .map(
            (e) => Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedItems.contains(e)) {
                      selectedItems.remove(e);
                    } else {
                      selectedItems.add(e);
                    }
                  });
                  widget.onChanged?.call(e);
                },
                child: _SingleChoiceItem(
                  e,
                  isSelected: selectedItems.contains(e),
                ),
              ),
            ),
          )
          .toList(),
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
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: isSelected
              ? SvgPicture.asset('assets/icons/ic_checkbox_selected.svg')
              : SvgPicture.asset('assets/icons/ic_checkbox_unchecked.svg'),
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

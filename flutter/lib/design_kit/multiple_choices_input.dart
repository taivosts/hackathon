import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MultipleChoicesInput extends StatefulWidget {
  const MultipleChoicesInput({
    super.key,
    required this.values,
    this.onChanged,
    this.selectedValues = const [],
  });

  final List<String> values;
  final List<String> selectedValues;
  final Function(List<String>)? onChanged;

  @override
  State<MultipleChoicesInput> createState() => _MultipleChoicesInputState();
}

class _MultipleChoicesInputState extends State<MultipleChoicesInput> {
  List<String> selectedValues = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedValues = widget.selectedValues;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.values
          .map(
            (e) => GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedValues.contains(e)) {
                    selectedValues.remove(e);
                  } else {
                    selectedValues.add(e);
                  }
                });
                widget.onChanged?.call(selectedValues);
              },
              child: _SingleChoiceItem(
                e,
                isSelected: selectedValues.contains(e),
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

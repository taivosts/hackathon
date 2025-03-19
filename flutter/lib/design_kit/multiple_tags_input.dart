import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MultipleTagsInput extends StatefulWidget {
  const MultipleTagsInput({
    super.key,
    required this.title,
    required this.values,
    this.onChanged,
    this.isAddable,
    this.backgroundColor = AppColors.greyLighten5,
    this.onAdding,
    this.padding = const EdgeInsets.all(16),
    this.isTransparentBackground = false,
    this.isReadOnly = false,
    this.selectedValues = const [],
  });

  final String title;
  final List<String> values;
  final Function(List<String>)? onChanged;
  final bool? isAddable;
  final Color backgroundColor;
  final VoidCallback? onAdding;
  final EdgeInsets padding;
  final bool isTransparentBackground;
  final bool isReadOnly;
  final List<String> selectedValues;

  @override
  State<MultipleTagsInput> createState() => _MultipleTagsInputState();
}

class _MultipleTagsInputState extends State<MultipleTagsInput> {
  Set<String> selectedItems = <String>{};

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MultipleTagsInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedItems = List.of(widget.selectedValues).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: double.infinity,
      decoration: widget.isTransparentBackground
          ? null
          : BoxDecoration(
              color: widget.backgroundColor,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 1), blurRadius: 2)
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
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.values
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          if (widget.isReadOnly) {
                            return;
                          }
                          setState(() {
                            if (selectedItems.contains(e)) {
                              selectedItems.remove(e);
                            } else {
                              selectedItems.add(e);
                            }

                            widget.onChanged?.call(selectedItems.toList());
                          });
                        },
                        child: _Tag(
                          e,
                          isSelected:
                              widget.isReadOnly || selectedItems.contains(e),
                        ),
                      ),
                    )
                    .toList() +
                (widget.isAddable == true
                    ? [
                        GestureDetector(
                          onTap: widget.onAdding,
                          child: const _AddingTag(),
                        )
                      ]
                    : []),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.title, {this.isSelected = false});
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.greyLighten3,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        title,
        style: AppFont.button(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}

class _AddingTag extends StatelessWidget {
  const _AddingTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.accent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/icons/ic_add_circle.svg'),
          const SizedBox(width: 4),
          Text(
            'ADD',
            style: AppFont.button(color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}

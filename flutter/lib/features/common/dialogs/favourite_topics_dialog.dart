import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'base_dialog.dart';

class FavouriteTopicsDialog {
  FavouriteTopicsDialog._();

  static Future<List<String>?> show({
    required String title,
    required String inputTitle,
    required String inputHint,
    required List<String> values,
  }) {
    return BaseDialog.show<List<String>>(
      title: title,
      content: _FavouriteTopicsDialogContent(
        values: values,
        inputTitle: inputTitle,
        inputHint: inputHint,
      ),
    );
  }
}

class _FavouriteTopicsDialogContent extends StatefulWidget {
  const _FavouriteTopicsDialogContent({
    required this.values,
    required this.inputTitle,
    required this.inputHint,
  });

  final List<String> values;
  final String inputTitle;
  final String inputHint;

  @override
  State<_FavouriteTopicsDialogContent> createState() =>
      _FavouriteTopicsDialogContentState();
}

class _FavouriteTopicsDialogContentState
    extends State<_FavouriteTopicsDialogContent> {
  List<String> values = [];
  final newValueController = TextEditingController();
  List<String> selectedValues = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      values = List.of(widget.values);
      selectedValues = List.of(widget.values);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 240),
            child: SingleChildScrollView(
              child: MultipleChoicesInput(
                values: values,
                selectedValues: selectedValues,
                onChanged: (newValues) {
                  setState(() {
                    selectedValues = newValues;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          PrimaryTextField(
            label: widget.inputTitle,
            hintText: widget.inputHint,
            isRequired: false,
            controller: newValueController,
          ),
          const SizedBox(height: 16),
          _AddItemButton(
            title: 'ADD',
            onTap: () {
              final newValue = newValueController.text;
              if (newValue.isNotEmpty && !values.contains(newValue)) {
                setState(() {
                  selectedValues.add(newValue);
                  values.insert(0, newValue);
                });
              }
              newValueController.text = '';
            },
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            title: 'SAVE',
            onTap: () => context.pop(selectedValues),
          ),
          const SizedBox(height: 16),
          SecondaryButton(
            title: 'CANCEL',
            onTap: () => context.pop(null),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _AddItemButton extends StatelessWidget {
  const _AddItemButton({
    required this.title,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: AppColors.accent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/ic_add_circle.svg'),
            const SizedBox(width: 4),
            Text(
              title,
              style: AppFont.button(color: AppColors.accent),
            ),
          ],
        ),
      ),
    );
  }
}

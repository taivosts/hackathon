import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'base_dialog.dart';

class NewTagDialog {
  NewTagDialog._();

  static Future<String?> show({
    required String title,
    required String inputTitle,
    required String inputHint,
  }) {
    return BaseDialog.show<String>(
      title: title,
      content: _NewTagDialogContent(
        inputTitle: inputTitle,
        inputHint: inputHint,
      ),
    );
  }
}

class _NewTagDialogContent extends StatefulWidget {
  const _NewTagDialogContent({
    required this.inputTitle,
    required this.inputHint,
  });

  final String inputTitle;
  final String inputHint;

  @override
  State<_NewTagDialogContent> createState() => _NewTagDialogContentState();
}

class _NewTagDialogContentState extends State<_NewTagDialogContent> {
  final newValueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: PrimaryTextField(
              label: widget.inputTitle,
              hintText: widget.inputHint,
              isRequired: false,
              controller: newValueController,
              maxLength: 20,
              validator: (value) {
                if (value == null || value.length < 3) {
                  return 'Data must be greater than 3 characters';
                }
                if (value.length > 20) {
                  return 'Data must be smaller than 20 characters';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 40),
          PrimaryButton(
              title: 'SAVE',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  context.pop(newValueController.text);
                }
              }),
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

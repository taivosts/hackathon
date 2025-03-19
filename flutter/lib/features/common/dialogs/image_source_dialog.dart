import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/features/common/dialogs/base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppImageSource {
  camera,
  gallery;

  String get title {
    switch (this) {
      case AppImageSource.camera:
        return 'Take Photo';
      case AppImageSource.gallery:
        return 'Choose from Library';
    }
  }
}

class ImageSourceDialog {
  ImageSourceDialog._();

  static Future<AppImageSource?> show() {
    return BaseDialog.show<AppImageSource>(
      title: 'Choose Source',
      content: const _ImageSourceDialogContent(),
    );
  }
}

class _ImageSourceDialogContent extends StatefulWidget {
  const _ImageSourceDialogContent();

  @override
  State<_ImageSourceDialogContent> createState() =>
      _ImageSourceDialogContentState();
}

class _ImageSourceDialogContentState extends State<_ImageSourceDialogContent> {
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
          ...AppImageSource.values.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: PrimaryButton(
                title: e.title,
                onTap: () {
                  context.pop(e);
                },
              ),
            ),
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

import 'package:flutter/material.dart';
import 'package:ai_dreamer/design_kit/text_style.dart';
import 'package:ai_dreamer/features/common/navigation_service.dart';
import 'package:ai_dreamer/resource/app_colors.dart';

class PrimaryAlertDialog extends StatelessWidget {
  const PrimaryAlertDialog({
    super.key,
    this.dismissButtonTitle,
    required this.confirmButtonTitle,
    required this.title,
    required this.description,
    this.onConfirmPressed,
    this.onDismissPressed,
  });

  final String? dismissButtonTitle;
  final String confirmButtonTitle;
  final String title;
  final String description;
  final Function? onConfirmPressed;
  final Function? onDismissPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 55),
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _makeTitleText(context),
            _makeDescriptionText(context),
            Container(
              height: 1,
              color: AppColors.title.withValues(alpha: 0.29),
            ),
            _AlertButton(
              title: confirmButtonTitle,
              style: _AlertButtonStyle.normal,
              onTap: () {
                onConfirmPressed?.call();
                Navigator.of(context).pop(true);
              },
            ),
            Container(
              height: 1,
              color: AppColors.title.withValues(alpha: 0.29),
            ),
            if (dismissButtonTitle != null)
              _AlertButton(
                title: dismissButtonTitle!,
                style: _AlertButtonStyle.cancel,
                onTap: () {
                  onDismissPressed?.call();
                  Navigator.of(context).pop(false);
                },
              ),
          ],
        ),
      ),
    );
  }

  Padding _makeDescriptionText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Text(
        description,
        style: Theme.of(context).textTheme.titleSmall,
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding _makeTitleText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 3),
      child: Text(
        title,
        style: AppFont.subHeading3(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Future<T?> show<T>() {
    if (NavigationService.navigatorKey.currentContext == null) {
      throw Exception();
    }
    return showDialog<T>(
      context: NavigationService.navigatorKey.currentContext!,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (_) => this,
    );
  }
}

enum _AlertButtonStyle { normal, cancel }

class _AlertButton extends StatelessWidget {
  const _AlertButton({
    required this.title,
    required this.style,
    required this.onTap,
  });

  final String title;
  final _AlertButtonStyle style;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 52,
        child: Text(
          title,
          style: _textStyle(context),
        ),
      ),
    );
  }

  TextStyle? _textStyle(BuildContext context) {
    switch (style) {
      case _AlertButtonStyle.normal:
        return AppFont.button();
      case _AlertButtonStyle.cancel:
        return Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontSize: 13,
            );
    }
  }
}

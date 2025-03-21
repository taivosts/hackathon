import 'dart:ui';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ai_dreamer/features/common/navigation_service.dart';

class LoadingOverlay {
  OverlayEntry? _overlay;

  LoadingOverlay._privateConstructor();
  static final LoadingOverlay shared = LoadingOverlay._privateConstructor();

  void show({BuildContext? context}) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) => AbsorbPointer(
          absorbing: true,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 42,
                    height: 42,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      NavigationService.navigatorKey.currentState?.overlay?.insert(_overlay!);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay?.remove();
      _overlay = null;
    }
  }
}

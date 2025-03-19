import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/features/common/navigation_service.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseDialog {
  BaseDialog._();

  static Future<T?> show<T>({required String title, required Widget content}) {
    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) {
      throw Exception('Context not found');
    }
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: AppColors.greyLighten5,
          child: SafeArea(
            top: false,
            child: Material(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 8),
                          child: Container(
                            height: 5,
                            width: 48,
                            decoration: BoxDecoration(
                              color: AppColors.greyLighten2,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 16),
                          child: Text(
                            title,
                            style: AppFont.h5(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  content
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/features/feature.dart';
import 'package:ai_dreamer/features/login/login_page.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:ai_dreamer/resource/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  'Welcome to\n${AppConstants.appName}',
                  style: AppFont.h3(
                    color: AppColors.primary,
                  ).copyWith(height: 50 / 48),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Center(
                child: SizedBox(
                  width: 200,
                  child: PrimaryButton(
                    title: 'GET STARTED',
                    onTap: () => context
                        .push([GetStartedPage.path, LoginPage.path].join("/")),
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:ai_dreamer/design_kit/primary_app_bar.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class DesignExercisePage extends StatelessWidget {
  const DesignExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimaryAppBar(title: 'Design My Own Exercise'),
      body: Body(),
      backgroundColor: AppColors.greyLighten5,
    );
  }

  // Route
  static String get path => 'design_exercise';
}

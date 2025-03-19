import 'package:ai_dreamer/design_kit/secondary_button.dart';
import 'package:ai_dreamer/design_kit/text_style.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'base_dialog.dart';

enum AddNewOption { myFavourite, designExercise }

class AddNewExerciseDialog {
  AddNewExerciseDialog._();

  static Future<AddNewOption?> show() {
    return BaseDialog.show<AddNewOption>(
        title: 'Add New Exercise Option',
        content: const _AddNewExerciseDialogContent());
  }
}

class _AddNewExerciseDialogContent extends StatelessWidget {
  const _AddNewExerciseDialogContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _ExerciseSourceButton(
            iconPath: 'assets/icons/ic_star.svg',
            title: [
              Text(
                'Load From My Favourite',
                style: AppFont.subtitle2(color: AppColors.info),
              ),
              Row(
                children: [
                  Text('21', style: AppFont.subtitle1()),
                  const SizedBox(width: 4),
                  Text('Exercises', style: AppFont.b1()),
                ],
              ),
            ],
            onTap: () => context.pop(AddNewOption.myFavourite),
          ),
          const SizedBox(height: 16),
          _ExerciseSourceButton(
            iconPath: 'assets/icons/ic_note_add.svg',
            title: [
              Text(
                'Design My Own Exercise',
                style: AppFont.subtitle2(color: AppColors.info),
              ),
            ],
            onTap: () => context.pop(AddNewOption.designExercise),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: SecondaryButton(
              title: 'CANCEL',
              onTap: () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseSourceButton extends StatelessWidget {
  const _ExerciseSourceButton({
    required this.iconPath,
    required this.title,
    this.onTap,
  });

  final String iconPath;
  final List<Widget> title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 1), blurRadius: 2)
            ]),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE1238E),
                    Color(0xFFE1238E),
                    Color(0xFF29005A),
                    Color(0xFF29005A),
                  ],
                ),
              ),
              child: SvgPicture.asset(iconPath),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: title,
              ),
            ),
            SvgPicture.asset('assets/icons/ic_arrow_right.svg'),
          ],
        ),
      ),
    );
  }
}

import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/features/common/dialogs/base_dialog.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountDialog {
  DeleteAccountDialog._();

  static Future<bool?> show() {
    return BaseDialog.show<bool>(
      title: 'Delete Account',
      content: const _DeleteAccountDialogContent(),
    );
  }
}

class _DeleteAccountDialogContent extends StatelessWidget {
  const _DeleteAccountDialogContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            'Are you absolutely sure that you want to delete your account?',
            style: AppFont.b1(),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFBE9E7),
              border: Border(
                left: BorderSide(color: AppColors.error, width: 4),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                SvgPicture.asset('assets/icons/ in_alert.svg'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Please note that there is no option to restore the account or its data nor reuse the username once it\'s deleted.',
                      style: AppFont.subtitle1(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            title: 'DELETE ACCOUNT',
            onTap: () => context.pop(true),
            backgroundColor: const Color(0xFFE1238E),
          ),
          const SizedBox(height: 16),
          SecondaryButton(
            title: 'CANCEL',
            onTap: () => context.pop(false),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

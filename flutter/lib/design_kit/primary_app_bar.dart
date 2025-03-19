import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_dreamer/design_kit/text_style.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function? onBackPressed;
  final List<Widget>? actions;

  const PrimaryAppBar({
    super.key,
    this.title = '',
    this.onBackPressed,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title.isNotEmpty
          ? Text(
              title,
              style: AppFont.h6(color: AppColors.accent),
            )
          : const SizedBox(),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GoRouter.of(context).canPop()
          ? GestureDetector(
              onTap: () {
                onBackPressed?.call();
                GoRouter.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 13, bottom: 13),
                child: SvgPicture.asset('assets/icons/ic_arrow_back.svg'),
              ),
            )
          : null,
      actions: actions,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.black.withOpacity(0.06),
          height: 1.0,
        ),
      ),
    );
  }
}

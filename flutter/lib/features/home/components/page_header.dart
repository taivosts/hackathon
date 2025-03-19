import 'package:ai_dreamer/design_kit/text_style.dart';
import 'package:ai_dreamer/domain_models/workspace.dart';
import 'package:ai_dreamer/features/home/bloc/home_bloc.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:ai_dreamer/resource/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    this.onCreateNew,
    super.key,
  });

  final VoidCallback? onCreateNew;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/sts_logo.svg',
                  height: 24,
                ),
                Text(
                  AppConstants.appName,
                  style: AppFont.caption().copyWith(color: AppColors.primary),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: PopupMenuButton<Workspace>(
                  elevation: 16,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.selectedWorkspace?.name ?? '',
                        style: AppFont.subtitle1()
                            .copyWith(color: AppColors.accent),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 12,
                            color: AppColors.accent,
                          ),
                        ),
                      )
                    ],
                  ),
                  onSelected: (value) {
                    context.read<HomeBloc>().add(WorkspaceSelected(value));
                  },
                  itemBuilder: (_) => state.workspaces
                      .map(
                        (value) => PopupMenuItem<Workspace>(
                          value: value,
                          child: Text(
                            value.name,
                            style:
                                AppFont.b1().copyWith(color: AppColors.accent),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            InkWell(
              focusColor: AppColors.primary.withValues(alpha: 0.2),
              hoverColor: AppColors.primary.withValues(alpha: 0.2),
              splashColor: AppColors.primary.withValues(alpha: 0.2),
              highlightColor: AppColors.primary.withValues(alpha: 0.2),
              onTap: () => onCreateNew?.call(),
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.library_add,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              focusColor: AppColors.primary.withValues(alpha: 0.2),
              hoverColor: AppColors.primary.withValues(alpha: 0.2),
              splashColor: AppColors.primary.withValues(alpha: 0.2),
              highlightColor: AppColors.primary.withValues(alpha: 0.2),
              onTap: () {
                context.read<HomeBloc>().add(LogoutRequested());
              },
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.logout,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

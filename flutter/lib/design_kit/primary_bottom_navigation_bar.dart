import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryBottomNavigationBar extends StatefulWidget {
  const PrimaryBottomNavigationBar({
    super.key,
    this.onTap,
  });

  final Function(int)? onTap;

  @override
  State<PrimaryBottomNavigationBar> createState() =>
      _PrimaryBottomNavigationBarState();
}

class _PrimaryBottomNavigationBarState
    extends State<PrimaryBottomNavigationBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: selectedIndex == 1 ? AppColors.accent : AppColors.greyLighten5,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 4),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(32),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 64,
            child: Row(
              children: [
                const Spacer(),
                PrimaryBottomNavigationBarItem(
                  title: 'Home',
                  iconPath: 'assets/icons/ic_home.svg',
                  selectedIconPath: 'assets/icons/ic_home_full.svg',
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    if (selectedIndex == 0) {
                      return;
                    }
                    setState(() {
                      selectedIndex = 0;
                    });
                    widget.onTap?.call(0);
                  },
                ),
                const Spacer(),
                PrimaryBottomNavigationBarItem(
                  title: 'Music',
                  iconPath: 'assets/icons/ic_music_note.svg',
                  selectedIconPath: 'assets/icons/ic_music_note_selected.svg',
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    if (selectedIndex == 1) {
                      return;
                    }
                    setState(() {
                      selectedIndex = 1;
                    });
                    widget.onTap?.call(1);
                  },
                ),
                const Spacer(),
                // PrimaryBottomNavigationBarItem(
                //   title: 'Favourite',
                //   iconPath: 'assets/icons/ic_star_outline.svg',
                //   selectedIconPath: 'assets/icons/ic_star_full.svg',
                //   isSelected: selectedIndex == 2,
                //   onTap: () {
                //     if (selectedIndex == 2) {
                //       return;
                //     }
                //     setState(() {
                //       selectedIndex = 2;
                //     });
                //     widget.onTap?.call(2);
                //   },
                // ),
                // const Spacer(),
                // PrimaryBottomNavigationBarItem(
                //   title: 'Journal',
                //   iconPath: 'assets/icons/ic_book.svg',
                //   selectedIconPath: 'assets/icons/ic_book_full.svg',
                //   isSelected: selectedIndex == 3,
                //   onTap: () {
                //     if (selectedIndex == 3) {
                //       return;
                //     }
                //     setState(() {
                //       selectedIndex = 3;
                //     });
                //     widget.onTap?.call(3);
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryBottomNavigationBarItem extends StatelessWidget {
  const PrimaryBottomNavigationBarItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.selectedIconPath,
    required this.isSelected,
    this.onTap,
  });

  final String title;
  final String iconPath;
  final String selectedIconPath;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isSelected
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    selectedIconPath,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: AppFont.subtitle2(color: Colors.white),
                  )
                ],
              ),
            )
          : SvgPicture.asset(
              iconPath,
              colorFilter:
                  const ColorFilter.mode(AppColors.accent, BlendMode.srcIn),
            ),
    );
  }
}

import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_dreamer/features/feature.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  static List<String> tabs = [
    HomePage.path,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: PrimaryBottomNavigationBar(
        onTap: (index) => _goOtherTab(context, index),
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    GoRouter router = GoRouter.of(context);
    String location = tabs[index];
    router.go(location);
  }
}

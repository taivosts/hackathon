import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Saigon Technology Solutions',
            style: AppFont.h3(),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  // Route
  static String get path => '/splash';
}

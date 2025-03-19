import 'package:flutter/material.dart';

class BaseBody extends StatelessWidget {
  const BaseBody({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            'assets/images/img_general_bg.jpg',
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}

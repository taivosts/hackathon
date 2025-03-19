import 'package:flutter/material.dart';
import 'components/body.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      backgroundColor: Colors.white,
    );
  }

  // Route
  static String get path => '/get_started';
}

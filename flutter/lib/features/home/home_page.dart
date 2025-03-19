import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_dreamer/features/home/bloc/home_bloc.dart';
import 'components/body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        userRepository: context.read(),
        anythingLLMRepository: context.read(),
        authenticationRepository: context.read(),
      ),
      child: const Scaffold(
        body: Body(),
        backgroundColor: AppColors.greyLighten5,
      ),
    );
  }

  // Route
  static String get path => '/home';
}

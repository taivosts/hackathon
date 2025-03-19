import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'components/body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // Route
  static String get path => 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          userRepository: context.read(),
          authenticationRepository: context.read(),
        ),
        child: const Body(),
      ),
      backgroundColor: AppColors.greyLighten5,
    );
  }
}

import 'package:ai_dreamer/design_kit/design_kit.dart';
import 'package:ai_dreamer/resource/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_dreamer/features/login/bloc/login_bloc.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void handleLogin() {
      final username = usernameController.text;
      final password = passwordController.text;
      context.read<LoginBloc>().add(LoginSubmitted(username, password));
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/sts_logo.svg'),
            const SizedBox(height: 64),
            SecondaryTextField(
              controller: usernameController,
              hintText: 'Username',
            ),
            const SizedBox(height: 16),
            SecondaryTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              backgroundColor: AppColors.primary,
              onTap: handleLogin,
              title: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}

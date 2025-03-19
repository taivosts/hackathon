import 'package:ai_dreamer/features/app/app_session.dart';
import 'package:ai_dreamer/features/common/dialogs/primary_alert_dialog.dart';
import 'package:ai_dreamer/network/parameters/user_login_params.dart';
import 'package:ai_dreamer/network/repositories/repositories.dart';
import 'package:ai_dreamer/utils/network_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;
  LoginBloc({
    required this.userRepository,
    required this.authenticationRepository,
  }) : super(const LoginState.unknown()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (event.username.isEmpty || event.password.isEmpty) {
      // Show warning popup

      await const PrimaryAlertDialog(
        confirmButtonTitle: "OK",
        title: 'Error',
        description: 'Username and password cannot be empty',
      ).show();
    } else {
      // Handle login logic here
      final credential = await callWithIndicatorAndPopupError(
        () => userRepository.requesToken(
          params: UserLoginParams(
            username: event.username,
            password: event.password,
          ),
        ),
      );
      AppSession.shared.setCredentials(credential);
      authenticationRepository.loggedIn();
    }
  }
}

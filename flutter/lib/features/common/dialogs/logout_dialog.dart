import 'package:ai_dreamer/features/common/dialogs/primary_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_dreamer/features/common/navigation_service.dart';
import 'package:ai_dreamer/features/authentication/bloc/authentication_bloc.dart';

class LogoutDialog {
  LogoutDialog._();

  static void show() {
    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) {
      throw Exception('Context not found');
    }
    showDialog(
      context: context,
      builder: (_) => const PrimaryAlertDialog(
        confirmButtonTitle: "OK",
        title: "Finess Tracker",
        description: "Please login again",
      ),
    ).then(
      (value) => context
          .read<AuthenticationBloc>()
          .add(AuthenticationLogoutRequested()),
    );
  }
}

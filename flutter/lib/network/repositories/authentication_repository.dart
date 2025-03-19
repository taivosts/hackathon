import 'dart:async';
import 'package:ai_dreamer/domain_models/credentials.dart';
import 'package:dio/dio.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;
  void loggedIn();
  void logOut();
  void dispose();
}

class RemoteAuthenticationRepository extends AuthenticationRepository {
  final Dio dio;
  final _controller = StreamController<AuthenticationStatus>();
  final Future<Credentials?> previousCredentials;

  RemoteAuthenticationRepository(
      {required this.dio, required this.previousCredentials});

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final credentials = await previousCredentials;
    if (credentials != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  @override
  void loggedIn() {
    _controller.add(AuthenticationStatus.authenticated);
  }

  @override
  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  void dispose() => _controller.close();
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_dreamer/features/app/app_session.dart';
import 'package:ai_dreamer/features/authentication/bloc/authentication_bloc.dart';
import 'package:ai_dreamer/network/http_client_factory.dart';
import 'package:ai_dreamer/network/repositories/repositories.dart';
import 'components/body.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  late final AnythingLLMRepository _anythingLLMRepository;

  late final Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = HttpClientFactory.createDio();
    _authenticationRepository = RemoteAuthenticationRepository(
      dio: _dio,
      previousCredentials: AppSession.shared.getCredentials(),
    );
    _anythingLLMRepository = RemoteAnythingLLMRepository(dio: _dio);
    _userRepository = RemoteUserRepository(dio: _dio);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => _authenticationRepository),
        RepositoryProvider(create: (_) => _userRepository),
        RepositoryProvider(create: (_) => _anythingLLMRepository),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: context.read(),
          userRepository: context.read(),
        ),
        child: const Body(),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }
}

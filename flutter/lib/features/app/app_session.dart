import 'package:ai_dreamer/domain_models/user_profile.dart';
import 'package:ai_dreamer/features/authentication/bloc/authentication_bloc.dart';
import 'package:ai_dreamer/features/common/navigation_service.dart';
import 'package:ai_dreamer/domain_models/credentials.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  // Singleton
  AppSession._privateConstructor();
  static final AppSession shared = AppSession._privateConstructor();

  // Keys
  final _jwtKey = 'jwt';
  final _threadSlugKey = 'thread_slug';

  // Storage
  // final _storage = const FlutterSecureStorage();

  // Obtain shared preferences.
  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  // Credentials
  Credentials? _credentials;
  Future<Credentials?> getCredentials() async {
    if (_credentials != null) {
      return _credentials!;
    }
    final tokenString = await _asyncPrefs.getString(_jwtKey);
    if (tokenString == null) {
      return null;
    }
    _credentials = Credentials.fromJson(tokenString);
    return _credentials;
  }

  Future<void> setCredentials(Credentials? newCredentials) async {
    if (newCredentials == null) {
      return await _asyncPrefs.remove(_jwtKey);
    }
    return await _asyncPrefs.setString(_jwtKey, newCredentials.toJson());
  }

  // Thread slug
  String? _threadSlug;
  Future<String?> getThreadSlug() async {
    if (_threadSlug != null) {
      return _threadSlug!;
    }
    _threadSlug = await _asyncPrefs.getString(_threadSlugKey);
    return _threadSlug;
  }

  Future<void> setThreadSlug(String? newThreadSlug) async {
    if (newThreadSlug == null) {
      return await _asyncPrefs.remove(_threadSlugKey);
    }
    return await _asyncPrefs.setString(_threadSlugKey, newThreadSlug);
  }

  // User
  UserProfile? get userProfile => NavigationService.navigatorKey.currentContext
      ?.read<AuthenticationBloc>()
      .state
      .user;
}

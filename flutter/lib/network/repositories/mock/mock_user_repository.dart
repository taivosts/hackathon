import 'dart:async';
import 'package:ai_dreamer/domain_models/credentials.dart';
import 'package:ai_dreamer/domain_models/user_profile.dart';
import 'package:ai_dreamer/network/parameters/user_login_params.dart';
import 'package:ai_dreamer/network/repositories/user_repository.dart';

class MockUserRepository extends UserRepository {
  @override
  Future<Credentials> requesToken({required UserLoginParams params}) async {
    return Credentials(
      refreshToken: 'mock_refresh_token',
      accessToken: 'mock_access_token',
    );
  }

  @override
  Future<UserProfile> getUser() async {
    return UserProfile(
      id: 1,
      email: 'mockuser@example.com',
      status: '',
      isActive: true,
    );
  }
}

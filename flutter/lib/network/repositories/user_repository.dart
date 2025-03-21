import 'dart:async';
import 'package:ai_dreamer/domain_models/credentials.dart';
import 'package:ai_dreamer/domain_models/user_profile.dart';
import 'package:ai_dreamer/network/parameters/user_login_params.dart';
import 'package:ai_dreamer/network/responses/request_token_response.dart';
import 'package:ai_dreamer/resource/app_constants.dart';
import 'package:ai_dreamer/utils/network_utils.dart';
import 'package:dio/dio.dart';

abstract class UserRepository {
  Future<UserProfile> getUser();
  Future<Credentials> requesToken({required UserLoginParams params});
}

class RemoteUserRepository extends UserRepository {
  Dio dio;

  RemoteUserRepository({
    required this.dio,
  });

  @override
  Future<Credentials> requesToken({required UserLoginParams params}) async {
    if (AppConstants.isDebugUI) {
      return Credentials(
        refreshToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZXN0IiwiaWF0IjoxNjI5MjM5MDIyfQ',
        accessToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZXN0IiwiaWF0IjoxNjI5MjM5MDIyfQ',
      );
    }
    final response = await handleRequestWithoutBase(
      () => dio.post('/api/request-token', data: params.toMap()),
      (data) => RequestTokenResponse.fromMap(data),
    );
    if (response.valid) {
      return Credentials(
          refreshToken: response.token!, accessToken: response.token!);
    } else {
      throw Exception(response.message);
    }
  }

  @override
  Future<UserProfile> getUser() {
    throw UnimplementedError();
  }
}

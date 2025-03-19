import 'dart:convert';

class UserLoginParams {
  final String username;
  final String password;

  UserLoginParams({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}



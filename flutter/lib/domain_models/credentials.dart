import 'dart:convert';

class Credentials {
  final String accessToken;
  final String refreshToken;

  Credentials({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory Credentials.fromMap(Map<String, dynamic> map) {
    return Credentials(
      accessToken: map['token'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Credentials.fromJson(String source) =>
      Credentials.fromMap(json.decode(source));
}

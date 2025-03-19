import 'dart:convert';

class RequestTokenResponse {
  final bool valid;
  final String? token;
  final String? message;

  RequestTokenResponse({
    required this.valid,
    this.token,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'valid': valid,
      'token': token,
      'message': message,
    };
  }

  factory RequestTokenResponse.fromMap(Map<String, dynamic> map) {
    return RequestTokenResponse(
      valid: map['valid'] ?? false,
      token: map['token'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestTokenResponse.fromJson(String source) => RequestTokenResponse.fromMap(json.decode(source));
}

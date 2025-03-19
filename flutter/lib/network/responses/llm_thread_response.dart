import 'dart:convert';
import 'package:ai_dreamer/domain_models/llm_thread.dart';

class LLMThreadResponse {
  final LLMThread? thread;
  final String? message;

  LLMThreadResponse({
    required this.thread,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'thread': thread?.toMap(),
      'message': message,
    };
  }

  factory LLMThreadResponse.fromMap(Map<String, dynamic> map) {
    return LLMThreadResponse(
      thread: map['thread'] != null ? LLMThread.fromMap(map['thread']) : null,
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LLMThreadResponse.fromJson(String source) => LLMThreadResponse.fromMap(json.decode(source));
}

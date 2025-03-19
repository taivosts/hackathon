import 'dart:convert';

class VoiceSearchParams {
  final int page;
  final int pageSize;
  final String query;
  final String knowledgeType;

  VoiceSearchParams({
    this.page = 0,
    this.pageSize = 30,
    required this.query,
    this.knowledgeType = 'all',
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'page_size': pageSize,
      'query': query,
      'knowledge_type': knowledgeType,
    };
  }

  factory VoiceSearchParams.fromMap(Map<String, dynamic> map) {
    return VoiceSearchParams(
      page: map['page']?.toInt() ?? 0,
      pageSize: map['page_size']?.toInt() ?? 0,
      query: map['query'] ?? '',
      knowledgeType: map['knowledge_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VoiceSearchParams.fromJson(String source) =>
      VoiceSearchParams.fromMap(json.decode(source));
}

import 'dart:convert';

class LLMThread {
  final int? id;
  final String? name;
  final String? slug;
  final int? workspaceId;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? lastUpdatedAt;

  LLMThread({
    required this.id,
    required this.name,
    required this.slug,
    required this.workspaceId,
    required this.userId,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'workspace_id': workspaceId,
      'user_id': userId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'lastUpdatedAt': lastUpdatedAt?.millisecondsSinceEpoch,
    };
  }

  factory LLMThread.fromMap(Map<String, dynamic> map) {
    return LLMThread(
      id: map['id']?.toInt(),
      name: map['name'],
      slug: map['slug'],
      workspaceId: map['workspace_id']?.toInt(),
      userId: map['user_id']?.toInt(),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
      lastUpdatedAt: map['lastUpdatedAt'] != null
          ? DateTime.parse(map['lastUpdatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LLMThread.fromJson(String source) =>
      LLMThread.fromMap(json.decode(source));
}

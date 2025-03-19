import 'dart:convert';

class Workspace {
  final int id;
  final String name;
  final String slug;

  Workspace({
    required this.id,
    required this.name,
    required this.slug,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }

  factory Workspace.fromMap(Map<String, dynamic> map) {
    return Workspace(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Workspace.fromJson(String source) =>
      Workspace.fromMap(json.decode(source));
}

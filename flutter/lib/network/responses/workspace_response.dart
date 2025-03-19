import 'dart:convert';
import 'package:ai_dreamer/domain_models/workspace.dart';

class WorkspaceResponse {
  final List<Workspace>? workspaces;
  final String? message;

  WorkspaceResponse({
    required this.workspaces,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'workspaces': workspaces?.map((x) => x.toMap()).toList(),
      'message': message,
    };
  }

  factory WorkspaceResponse.fromMap(Map<String, dynamic> map) {
    return WorkspaceResponse(
      workspaces: map['workspaces'] != null ? List<Workspace>.from(map['workspaces']?.map((x) => Workspace.fromMap(x))) : null,
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkspaceResponse.fromJson(String source) => WorkspaceResponse.fromMap(json.decode(source));
}

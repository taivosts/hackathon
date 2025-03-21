import 'dart:async';
import 'package:ai_dreamer/domain_models/chat_message_response.dart';
import 'package:ai_dreamer/domain_models/workspace.dart';
import 'package:ai_dreamer/network/repositories/anythingllm_repository.dart';

class MockAnythingLLMRepository implements AnythingLLMRepository {
  @override
  Future<List<Workspace>> fetchWorkspaces() async {
    return [
      Workspace(id: 1, name: 'Workspace 1', slug: 'workspace-1'),
      Workspace(id: 2, name: 'Workspace 2', slug: 'workspace-2'),
      Workspace(id: 3, name: 'Workspace 3', slug: 'workspace-3'),
    ];
  }

  @override
  Future<String> createNewThread({required String slug}) async {
    return 'mock-thread-slug';
  }

  @override
  Stream<ChatMessageResponse> fetchMessage({
    required String slug,
    required String threadSlug,
    required String question,
  }) async* {
    final responses = [
      "Hey there! Hope you're having an awesome day!",
      "Hello! It's great to see you today!",
      "Hi! How's everything going on your end?",
      "Good day! Wishing you lots of positivity and good vibes!",
      "Hey! Hope your day is filled with smiles and good energy!",
    ];

    final randomResponse = (responses..shuffle()).first;

    yield ChatMessageResponse(
      textResponse: randomResponse,
      close: true,
    );
  }
}

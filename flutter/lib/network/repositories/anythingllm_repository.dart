import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:ai_dreamer/domain_models/chat_message_response.dart';
import 'package:ai_dreamer/domain_models/workspace.dart';
import 'package:ai_dreamer/network/responses/llm_thread_response.dart';
import 'package:ai_dreamer/network/responses/workspace_response.dart';
import 'package:ai_dreamer/utils/app_logger.dart';
import 'package:ai_dreamer/utils/network_utils.dart';
import 'package:dio/dio.dart';

abstract class AnythingLLMRepository {
  Future<List<Workspace>> fetchWorkspaces();
  Future<String> createNewThread({required String slug});
  Stream<ChatMessageResponse> fetchMessage({
    required String slug,
    required String threadSlug,
    required String question,
  });
}

class RemoteAnythingLLMRepository implements AnythingLLMRepository {
  final Dio dio;

  RemoteAnythingLLMRepository({required this.dio});

  @override
  Stream<ChatMessageResponse> fetchMessage({
    required String slug,
    required String threadSlug,
    required String question,
  }) async* {
    final response = await dio.post<ResponseBody>(
      '/api/workspace/$slug/thread/$threadSlug/stream-chat',
      data: {
        "message": question,
        "attachments": [],
      },
      options: Options(
        headers: {
          "accept": "text/event-stream",
          "Content-Type": "application/json",
        },
        responseType: ResponseType.stream,
      ),
    );
    StreamTransformer<Uint8List, List<int>> unit8Transformer =
        StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        sink.add(List<int>.from(data));
      },
    );

    StreamTransformer<String, ChatMessageResponse> chatMessageTransformer =
        StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        final message = data.replaceAll("data: ", "").trim();
        if (message.isNotEmpty && message.contains("textResponse")) {
          final chatMessageResponse = ChatMessageResponse.fromJson(message);
          if (chatMessageResponse.close ?? false) {
            sink.add(chatMessageResponse);
            sink.close();
          } else {
            AppLogger.logInfo(
                "Event (${DateTime.now()}): ${chatMessageResponse.textResponse}");
            sink.add(chatMessageResponse);
          }
        }
      },
    );

    yield* response.data?.stream
            .transform(unit8Transformer)
            .transform(const Utf8Decoder())
            .transform(const LineSplitter())
            .transform(chatMessageTransformer) ??
        const Stream.empty();
  }

  @override
  Future<String> createNewThread({required String slug}) async {
    final threadResponse = await handleRequestWithoutBase(
      () => dio.post('/api/workspace/$slug/thread/new'),
      (data) => LLMThreadResponse.fromMap(data),
    );
    if (threadResponse.thread?.slug == null) {
      throw Exception(threadResponse.message);
    } else {
      return threadResponse.thread!.slug!;
    }
  }

  @override
  Future<List<Workspace>> fetchWorkspaces() async {
    final workspaceResponse = await handleRequestWithoutBase(
      () => dio.get('/api/workspaces'),
      (data) => WorkspaceResponse.fromMap(data),
    );
    if (workspaceResponse.message != null) {
      throw Exception(workspaceResponse.message);
    } else {
      return workspaceResponse.workspaces ?? [];
    }
  }
}

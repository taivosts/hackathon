import 'dart:convert';

class ChatMessageResponse {
  final String? uuid;
  final List<DocSource>? sources;
  final String? type;
  final String? textResponse;
  final bool? close;
  final bool? error;

  ChatMessageResponse({
    this.uuid,
    this.sources,
    this.type,
    this.textResponse,
    this.close,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'sources': sources?.map((x) => x.toMap()).toList(),
      'type': type,
      'textResponse': textResponse,
      'close': close,
      'error': error,
    };
  }

  factory ChatMessageResponse.fromMap(Map<String, dynamic> map) {
    return ChatMessageResponse(
      uuid: map['uuid'],
      sources: map['sources'] != null
          ? List<DocSource>.from(
              map['sources']?.map((x) => DocSource.fromMap(x)))
          : null,
      type: map['type'],
      textResponse: map['textResponse'],
      close: map['close'],
      error: (map['error'] is String) ? true : map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessageResponse.fromJson(String source) =>
      ChatMessageResponse.fromMap(json.decode(source));
}

class DocSource {
  final String? id;
  final String? url;
  final String? title;
  final String? docAuthor;
  final String? description;
  final String? docSource;
  final String? chunkSource;
  final String? published;
  final int? wordCount;
  final int? tokenCountEstimate;
  final String? text;
  final double? distance;
  final double? score;

  DocSource({
    this.id,
    this.url,
    this.title,
    this.docAuthor,
    this.description,
    this.docSource,
    this.chunkSource,
    this.published,
    this.wordCount,
    this.tokenCountEstimate,
    this.text,
    this.distance,
    this.score,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'docAuthor': docAuthor,
      'description': description,
      'docSource': docSource,
      'chunkSource': chunkSource,
      'published': published,
      'wordCount': wordCount,
      'tokenCountEstimate': tokenCountEstimate,
      'text': text,
      'distance': distance,
      'score': score,
    };
  }

  factory DocSource.fromMap(Map<String, dynamic> map) {
    return DocSource(
      id: map['id'],
      url: map['url'],
      title: map['title'],
      docAuthor: map['docAuthor'],
      description: map['description'],
      docSource: map['docSource'],
      chunkSource: map['chunkSource'],
      published: map['published'],
      wordCount: map['wordCount']?.toInt(),
      tokenCountEstimate: map['tokenCountEstimate']?.toInt(),
      text: map['text'],
      distance: map['distance']?.toDouble(),
      score: map['score']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocSource.fromJson(String source) =>
      DocSource.fromMap(json.decode(source));
}

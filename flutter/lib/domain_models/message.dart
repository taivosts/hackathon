enum MessageType { text, image, video, audio, thinking }

class Message {
  final String text;
  final MessageType type;
  final DateTime createdAt;
  final bool isGenerated;
  final List<DocsSource>? sources;

  Message({
    required this.text,
    required this.type,
    required this.createdAt,
    required this.isGenerated,
    this.sources,
  });
}

class DocsSource {
  final String title;
  final String url;
  DocsSource({
    required this.title,
    required this.url,
  });
}

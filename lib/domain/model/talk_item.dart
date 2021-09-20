class TalkItem extends Object {
  TalkItem({
    required this.id,
    required this.topicName,
    required this.title,
    required this.description,
    required this.url,
    required this.localUrl,
    required this.duration,
    required this.createdAt,
    this.publishedAt,
    required this.isPublic,
    required this.colorCode,
    this.playNumber = 0,
    this.likeNumber = 0,
    required this.createdUser,
  });

  final String id;
  final String topicName;
  final String? title;
  final String? description;
  String? url;
  final String? localUrl;
  final int duration;
  final DateTime createdAt;
  final DateTime? publishedAt;
  bool isPublic;
  final int colorCode;
  int playNumber;
  int likeNumber;
  final TalkUser createdUser;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TalkItem && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Uri get uri {
    return url != null ? Uri.parse(url!) : Uri.file(localUrl!);
  }

  void draft() {
    isPublic = false;
  }

  void publish(String? newUrl) {
    isPublic = true;
    url = url ?? newUrl;
  }
}

class TalkUser {
  TalkUser({required this.id, required this.name, required this.photoUrl});

  final String id;
  final String name;
  final String photoUrl;
}

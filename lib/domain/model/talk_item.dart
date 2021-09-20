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
  final String? url;
  final String? localUrl;
  final int duration;
  final DateTime createdAt;
  final DateTime? publishedAt;
  final bool isPublic;
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
    return isPublic ? Uri.parse(url!) : Uri.file(localUrl!);
  }

  TalkItem draftTalk({required TalkItem talkItem}) {
    return TalkItem(
      id: talkItem.id,
      localUrl: talkItem.localUrl,
      url: talkItem.url,
      topicName: talkItem.topicName,
      title: talkItem.title,
      description: talkItem.description,
      duration: talkItem.duration,
      publishedAt: talkItem.publishedAt,
      createdAt: talkItem.createdAt,
      colorCode: talkItem.colorCode,
      isPublic: false,
      likeNumber: talkItem.likeNumber,
      playNumber: talkItem.playNumber,
      createdUser: TalkUser(
        id: talkItem.createdUser.id,
        name: talkItem.createdUser.name,
        photoUrl: talkItem.createdUser.photoUrl,
      ),
    );
  }

  TalkItem publishTalk({required TalkItem talkItem}) {
    return TalkItem(
      id: talkItem.id,
      localUrl: talkItem.localUrl,
      url: talkItem.url,
      topicName: talkItem.topicName,
      title: talkItem.title,
      description: talkItem.description,
      duration: talkItem.duration,
      publishedAt: talkItem.publishedAt,
      createdAt: talkItem.createdAt,
      colorCode: talkItem.colorCode,
      isPublic: true,
      likeNumber: talkItem.likeNumber,
      playNumber: talkItem.playNumber,
      createdUser: TalkUser(
        id: talkItem.createdUser.id,
        name: talkItem.createdUser.name,
        photoUrl: talkItem.createdUser.photoUrl,
      ),
    );
  }
}

class TalkUser {
  TalkUser({required this.id, required this.name, required this.photoUrl});

  final String id;
  final String name;
  final String photoUrl;
}

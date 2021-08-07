class TalkItem extends Object {
  TalkItem({
    required this.id,
    required this.talkTopic,
    required this.title,
    required this.description,
    required this.time,
    required this.recordedAt,
    required this.colorCode,
    required this.isPublic,
    this.like = 0,
    this.view = 0,
  });

  final String id;
  final String talkTopic;
  final String title;
  final String description;
  final int time;
  final DateTime recordedAt;
  final int colorCode;
  final bool isPublic;
  int like;
  int view;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TalkItem && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

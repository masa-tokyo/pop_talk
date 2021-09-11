class TalkTopic extends Object {
  TalkTopic({
    required this.id,
    required this.name,
    required this.colorCode,
  });

  final String id;
  final String name;
  final int colorCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TalkTopic && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

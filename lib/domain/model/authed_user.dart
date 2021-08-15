class AuthedUser {
  AuthedUser({
    required this.id,
    required this.name,
    required this.isAnonymous,
    required this.followUserIds,
    required this.likeTalkIds,
  });

  final String id;
  final String name;
  final bool isAnonymous;
  final List<String> followUserIds;
  final List<String> likeTalkIds;
}

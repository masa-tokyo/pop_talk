class AuthedUser {
  AuthedUser({
    required this.id,
    required this.name,
    required this.isAnonymous,
    required this.followingUserIds,
    required this.likeTalkIds,
    required this.followerNumber,
    required this.likeNumber,
  });

  final String id;
  final String name;
  final bool isAnonymous;
  final List<String> followingUserIds;
  final List<String> likeTalkIds;
  final int followerNumber;
  final int likeNumber;
}

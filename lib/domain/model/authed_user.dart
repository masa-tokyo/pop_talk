import 'package:pop_talk/domain/model/interface.dart';

class AuthedUser implements HasProfile {
  AuthedUser({
    required this.id,
    required this.name,
    required this.isAnonymous,
    required this.followingUserIds,
    required this.likeTalkIds,
    required this.followerNumber,
    required this.likeNumber,
    required this.photoUrl,
  });

  final String id;
  @override
  String name;
  final bool isAnonymous;
  final List<String> followingUserIds;
  final List<String> likeTalkIds;
  final int followerNumber;
  final int likeNumber;
  @override
  final String photoUrl;

  void likeTalk(String talkId) {
    final talkIds = {...likeTalkIds, talkId}.toList();
    likeTalkIds
      ..clear()
      ..addAll(talkIds);
  }

  void followUser(String userId) {
    final userIds = {...followingUserIds, userId}.toList();
    followingUserIds
      ..clear()
      ..addAll(userIds);
  }

  bool alreadyLikeTalk(String talkId) {
    return likeTalkIds.contains(talkId);
  }

  bool alreadyFollowUser(String userId) {
    return followingUserIds.contains(userId);
  }

  void changeUserName(String newName) {
    name = newName;
  }
}

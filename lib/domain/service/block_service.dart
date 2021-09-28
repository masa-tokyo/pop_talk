
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';

class BlockService {
  BlockService(this._authedUser);

  final AuthedUser _authedUser;

  List<TalkItem> filterTalks(List<TalkItem> talks) {
    return talks.where((talk) {
      return !_authedUser.blockUserIds.contains(talk.createdUser.id);
    }).toList();
  }
}

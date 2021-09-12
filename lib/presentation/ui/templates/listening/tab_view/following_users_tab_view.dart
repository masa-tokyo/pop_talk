import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/organisms/listening_tile.dart';

class FollowingUsersTabView extends StatelessWidget {
  const FollowingUsersTabView({
    required this.followLists,
});
  final List<TalkItem> followLists;

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: followLists.length,
      itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: ListeningTile(
            talkItem: followLists[i],
          ),
        );
      },
    );
  }
}

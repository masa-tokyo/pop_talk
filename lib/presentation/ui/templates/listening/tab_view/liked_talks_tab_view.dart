import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/organisms/listening_tile.dart';

class LikedTalksTabView extends StatelessWidget {
  const LikedTalksTabView({
    required this.likeLists,
});

  final List<TalkItem> likeLists;

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: likeLists.length,
      itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: ListeningTile(
            talkItem: likeLists[i],
          ),
        );
      },
    );
  }
}

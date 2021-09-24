import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/notifier/player.dart';
import 'package:pop_talk/presentation/ui/templates/my_talk/preview_page.dart';
import 'package:pop_talk/presentation/ui/utils/functions.dart';

class TalkTile extends StatelessWidget {
  const TalkTile({
    required this.talkItem,
    required this.isPublic,
  });

  final TalkItem talkItem;
  final bool isPublic;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.only(top: 4),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _showModalBottomSheet(
            context: context,
            talkItem: talkItem,
            playerNotifier: watch(playerProvider),
          ),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            constraints: const BoxConstraints(
                                minHeight: 120, maxWidth: 200),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(12),
                              color: Color(talkItem.colorCode),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: Colors.black26,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      talkItem.topicName,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.black26,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      child: Text(
                                        convertDurationToString(
                                          Duration(seconds: talkItem.duration),
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isPublic)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 200),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    // TODO(any): 聞かれた回数も取る
                                    // Row(
                                    //   children: [
                                    //     const Icon(Icons.headphones_rounded),
                                    //     Text('${talkItem.playNumber}')
                                    //   ],
                                    // ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.favorite_outline,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(width: 4),
                                        Text('${talkItem.likeNumber}')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 12),
                        constraints:
                            const BoxConstraints(maxWidth: 200, minHeight: 120),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              talkItem.title ?? '無題',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              talkItem.description ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                                '${talkItem.createdAt.year}/${talkItem.createdAt.month}/${talkItem.createdAt.day} 保存')
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      );
    });
  }
}

void _showModalBottomSheet({
  required BuildContext context,
  required TalkItem talkItem,
  required PlayerNotifier playerNotifier,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter modalSetState) {
          return SizedBox(
            child: PreviewPage(
              talkItem: talkItem,
              modalSetState: modalSetState,
              playerNotifier: playerNotifier,
            ),
          );
        },
      );
    },
  );
}

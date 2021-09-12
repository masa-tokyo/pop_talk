import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/templates/my_talk/preview_page.dart';

class TalkTile extends StatelessWidget {
  const TalkTile({
    required this.talkItem,
    required this.isPublic,
  });

  final TalkItem talkItem;
  final bool isPublic;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12, left: 12),
      padding: const EdgeInsets.only(top: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _showModalBottomSheet(
          context: context,
          talkItem: talkItem,
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      constraints:
                          const BoxConstraints(minHeight: 140, maxWidth: 180),
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.black26,
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
                          Positioned(
                            right: 10,
                            bottom: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.black26,
                              ),
                              child: Text(
                                '${talkItem.duration}分',
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
                        ],
                      ),
                    ),
                    if (isPublic)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 180),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.headphones_rounded),
                                Text('${talkItem.playNumber}')
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.favorite_outline),
                                Text('${talkItem.likeNumber}')
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    constraints:
                        const BoxConstraints(maxWidth: 180, minHeight: 140),
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
                            '${talkItem.publishedAt.year}/${talkItem.publishedAt.month}/${talkItem.publishedAt.day} 保存')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showModalBottomSheet({
  required BuildContext context,
  required TalkItem talkItem,
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
            ),
          );
        },
      );
    },
  );
}

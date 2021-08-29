import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/pages/preview.dart';

class TalkTile extends StatelessWidget {
  const TalkTile({
    required this.talkItem,
    required this.isPublic,
  });

  final TalkItem talkItem;
  final bool isPublic;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: width * 0.36,
                          height: height * 0.12,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            borderRadius: BorderRadius.circular(12),
                            color: Color(talkItem.colorCode),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
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
                          SizedBox(
                            width: width * 0.36,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    SizedBox(
                      height: height * 0.12,
                      width: width * 0.40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  ],
                ),
              ),
            ],
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
            height: MediaQuery.of(context).size.height * 0.88,
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

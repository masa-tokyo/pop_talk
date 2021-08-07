import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';

class SavedTalkTile extends StatelessWidget {
  const SavedTalkTile(this.talkItem);

  final TalkItem talkItem;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // TODO(MyTalkTeam): プレビュー画面表示
        },
        child: Column(
          children: [
            const Divider(
              color: Colors.black38,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            talkItem.talkTopic,
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
                              '${talkItem.time}分',
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
                  SizedBox(
                    height: height * 0.12,
                    width: width * 0.40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          talkItem.title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          talkItem.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                            '${talkItem.recordedAt.year}/${talkItem.recordedAt.month}/${talkItem.recordedAt.day} 保存')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

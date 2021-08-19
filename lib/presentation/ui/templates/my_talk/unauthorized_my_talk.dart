import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/organisms/talk_tile.dart';
import 'package:pop_talk/presentation/ui/pages/resister.dart';

class UnauthorizedMyTalk extends StatelessWidget {
  const UnauthorizedMyTalk({Key? key, required this.savedTalkItems})
      : super(key: key);

  final List<TalkItem> savedTalkItems;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              color: Colors.white,
              height: height * 0.20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'トークを配信するにはアカウントを\n登録する必要があります',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                          width: width * 0.36,
                          height: height * 0.06,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO(MyTalkTeam): 新規登録
                          },
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.copyWith(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                              ),
                          child: const Text('新規登録'),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                          width: width * 0.36,
                          height: height * 0.06,
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext builder) {
                                  return const ResisterPage();
                                },
                              );
                            },
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style
                                ?.copyWith(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor),
                                ),
                            child: const Text('ログイン')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.20 * savedTalkItems.length,
              width: width * 0.90,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: savedTalkItems.length,
                itemBuilder: (BuildContext context, int i) {
                  return TalkTile(
                    talkItem: savedTalkItems[i],
                    isPublic: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

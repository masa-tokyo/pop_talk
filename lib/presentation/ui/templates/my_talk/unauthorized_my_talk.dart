import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/organisms/talk_tile.dart';

class UnauthorizedMyTalk extends StatelessWidget {
  const UnauthorizedMyTalk({Key? key, required this.talkItems})
      : super(key: key);

  final List<TalkItem> talkItems;
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
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(12),
              ),
              height: height * 0.20,
              width: width * 0.90,
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
                              // TODO(MyTalkTeam): ログイン
                            },
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style
                                ?.copyWith(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green),
                                ),
                            child: const Text('ログイン')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.18 * talkItems.length,
              width: width * 0.90,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: talkItems.length,
                itemBuilder: (BuildContext context, int i) {
                  return SavedTalkTile(talkItems[i]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

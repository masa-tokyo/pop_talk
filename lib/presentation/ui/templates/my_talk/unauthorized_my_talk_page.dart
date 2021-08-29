import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/organisms/talk_tile.dart';
import 'package:pop_talk/presentation/ui/pages/resister.dart';

class UnauthorizedMyTalkPage extends StatelessWidget {
  const UnauthorizedMyTalkPage({Key? key, required this.savedTalkItems})
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
                          onPressed: () => _showModalBottomSheet(
                            context: context,
                            isMember: false,
                          ),
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
                            onPressed: () => _showModalBottomSheet(
                                  context: context,
                                  isMember: true,
                                ),
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

void _showModalBottomSheet({
  required BuildContext context,
  required bool isMember,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter modalSetState) {
          return ResisterPage(
            isMember: isMember,
            modalSetState: modalSetState,
          );
        },
      );
    },
  );
}

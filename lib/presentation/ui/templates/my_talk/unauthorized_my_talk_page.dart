import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/organisms/talk_tile.dart';
import 'package:pop_talk/presentation/ui/pages/register.dart';

class UnauthorizedMyTalkPage extends StatelessWidget {
  const UnauthorizedMyTalkPage({Key? key, required this.draftTalkItems})
      : super(key: key);

  final List<TalkItem> draftTalkItems;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              color: Colors.white,
              constraints: const BoxConstraints(minHeight: 140, maxWidth: 565),
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
                        constraints:
                            const BoxConstraints(maxWidth: 150, minHeight: 20),
                        child: ElevatedButton(
                          onPressed: () => _showModalBottomSheet(
                            context: context,
                            isMember: false,
                          ),
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.copyWith(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 32,
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                              ),
                          child: const Text('新規登録'),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 150, minHeight: 20),
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
                                      const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 32,
                                  )),
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
            Container(
              height: draftTalkItems.isEmpty
                  ? 400
                  : (175 * draftTalkItems.length).toDouble(),
              constraints: const BoxConstraints(maxWidth: 600),
              child: draftTalkItems.isEmpty
                  ? const Center(
                      child: Text(
                        '保存済みのトークはまだありません',
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: draftTalkItems.length,
                      itemBuilder: (BuildContext context, int i) {
                        return TalkTile(
                          talkItem: draftTalkItems[i],
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
          return RegisterPage(
            isMember: isMember,
            modalSetState: modalSetState,
          );
        },
      );
    },
  );
}

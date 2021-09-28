import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pop_talk/presentation/ui/organisms/talk_options.dart';
import 'package:pop_talk/presentation/ui/utils/modal_bottom_sheet.dart';

class ListeningTile extends StatelessWidget {
  const ListeningTile({
    required this.talkItem,
    this.onTap,
  });

  final TalkItem talkItem;
  final void Function(TalkItem talk)? onTap;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd hh:mm');
    return InkWell(
      onTap: onTap == null
          ? () {}
          : () {
              onTap!(talkItem);
            },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${dateFormat.format(talkItem.publishedAt!)} 配信',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            await showBottomSheetPage(
                              context: context,
                              page: TalkOptions(
                                talkId: talkItem.id,
                                userId: talkItem.createdUser.id,
                              ),
                            );
                          },
                          child: const Icon(Icons.more_horiz),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(talkItem.createdUser.photoUrl),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(talkItem.topicName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(talkItem.createdUser.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Consumer(builder: (context, watch, _) {
                          final _authNotifier = watch(authProvider);
                          final _currentUser = _authNotifier.currentUser!;
                          if (_currentUser.alreadyLikeTalk(talkItem.id)) {
                            return Icon(
                              Icons.favorite,
                              size: 24,
                              color: Theme.of(context).primaryColor,
                            );
                          } else {
                            return InkWell(
                              onTap: () async {
                                await _authNotifier.likeTalk(talkItem);
                              },
                              child: const Icon(
                                Icons.favorite_border,
                                size: 24,
                                color: Color(0xFFBDBDBD),
                              ),
                            );
                          }
                        }),
                      ],
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

import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/talk_list.dart';

class ListeningTile extends StatelessWidget {
  const ListeningTile({
    required this.talkItem,
  });

  final TalkItem talkItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Theme.of(context).primaryColor),
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Text('${talkItem.publishedAt}配信'),
                  )),
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
                            image:
                                NetworkImage(talkItem.createdUser.photoUrl))),
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
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            _authNotifier.likeTalk(talkItem);
                            context.read(talkListProvider).fetchLikeLists();
                          },
                          child: const Icon(
                            Icons.favorite_border,
                            size: 20,
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
    );
  }
}

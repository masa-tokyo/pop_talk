import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/presentation/ui/organisms/talk_tile.dart';
import 'package:pop_talk/presentation/notifier/talk_item.dart';

class AuthorizedMyTalk extends StatelessWidget {
  const AuthorizedMyTalk({
    Key? key,
    required this.savedTalkItems,
    required this.postedTalkItems,
    required this.userData,
  }) : super(key: key);

  final List<TalkItem> savedTalkItems;
  final List<TalkItem> postedTalkItems;
  final AuthedUser userData;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black12,
                    backgroundImage: const AssetImage(
                      'assets/images/default_avatar.png',
                    ),
                    child: ClipOval(
                      // TODO(MyTalkTeam): Image.networkでstorageに保存したアイコンを表示する。一旦デフォの画像を置いとく。
                      child: Image.asset(
                        'assets/images/default_avatar.png',
                        fit: BoxFit.fill,
                        errorBuilder: (c, o, s) {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userData.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'フォロワー 100  いいね 100',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, watch, __) {
                final _talkItemNotifier = watch(talkItemProvider);
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black45,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black38),
                          ),
                          onTap: (index) {
                            _talkItemNotifier.changeTabIndex(index: index);
                          },
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Tab(text: '保存済み'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Tab(text: '配信済み'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _talkItemNotifier.tabIndex == 0
                              ? height * 0.18 * savedTalkItems.length
                              : height * 0.20 * postedTalkItems.length,
                          width: width * 0.90,
                          child: TabBarView(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: savedTalkItems.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return TalkTile(
                                    talkItem: savedTalkItems[i],
                                    isPublic: false,
                                  );
                                },
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: savedTalkItems.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return TalkTile(
                                    talkItem: postedTalkItems[i],
                                    isPublic: true,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

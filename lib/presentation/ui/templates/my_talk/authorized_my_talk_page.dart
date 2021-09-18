import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/presentation/ui/organisms/talk_tile.dart';

class AuthorizedMyTalkPage extends StatefulWidget {
  const AuthorizedMyTalkPage({
    Key? key,
    required this.savedTalkItems,
    required this.postedTalkItems,
    required this.userData,
  }) : super(key: key);

  final List<TalkItem> savedTalkItems;
  final List<TalkItem> postedTalkItems;
  final AuthedUser userData;

  @override
  _AuthorizedMyTalkPageState createState() => _AuthorizedMyTalkPageState();
}

class _AuthorizedMyTalkPageState extends State<AuthorizedMyTalkPage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8, right: 12, left: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              constraints: const BoxConstraints(minHeight: 140, maxWidth: 565),
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
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minHeight: 140, maxWidth: 200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.userData.name,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'フォロワー 100  いいね 100',
                              style: Theme.of(context).textTheme.bodyText2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  children: [
                    Container(
                      height: 32,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black45,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onTap: (index) {
                          setState(() {
                            _tabIndex = index;
                          });
                        },
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Tab(
                              child: Text('保存済み'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Tab(
                              child: Text('配信済み'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: _tabIndex == 0
                          ? (175 * widget.savedTalkItems.length).toDouble()
                          : (195 * widget.postedTalkItems.length).toDouble(),
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.savedTalkItems.length,
                            itemBuilder: (BuildContext context, int i) {
                              return TalkTile(
                                talkItem: widget.savedTalkItems[i],
                                isPublic: false,
                              );
                            },
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.postedTalkItems.length,
                            itemBuilder: (BuildContext context, int i) {
                              return TalkTile(
                                talkItem: widget.postedTalkItems[i],
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
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/domain/model/authed_user.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/notifier/my_talk.dart';
import 'package:pop_talk/presentation/ui/atoms/circular_progress_indicator.dart';
import 'package:pop_talk/presentation/ui/atoms/user_avator.dart';
import 'package:pop_talk/presentation/ui/organisms/logout_confirmation.dart';
import 'package:pop_talk/presentation/ui/organisms/talk_tile.dart';
import 'package:pop_talk/presentation/ui/templates/my_talk/profile_edit_page.dart';
import 'package:pop_talk/presentation/ui/utils/modal_bottom_sheet.dart';

class AuthorizedMyTalkPage extends StatefulWidget {
  const AuthorizedMyTalkPage({
    Key? key,
    required this.draftTalkItems,
    required this.publishTalkItems,
    required this.authedUser,
  }) : super(key: key);

  final List<TalkItem> draftTalkItems;
  final List<TalkItem> publishTalkItems;
  final AuthedUser authedUser;

  @override
  _AuthorizedMyTalkPageState createState() => _AuthorizedMyTalkPageState();
}

class _AuthorizedMyTalkPageState extends State<AuthorizedMyTalkPage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 4, right: 16),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      await showBottomSheetPage(
                          context: context, page: const LogoutConfirmation());
                    },
                    child: const Icon(Icons.more_horiz),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UserAvatar(profile: widget.authedUser),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(minHeight: 140, maxWidth: 200),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.authedUser.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontSize: 24),
                            ),
                            const SizedBox(height: 4),
                            TextButton(
                              onPressed: () async {
                                await showBottomSheetPage(
                                    context: context,
                                    page: ProfileEditPage(
                                        authedUser: widget.authedUser));
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 16,
                                ),
                              ),
                              child: Text(
                                'プロフィール編集',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${widget.authedUser.followerNumber}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  'フォロワー',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${widget.authedUser.likeNumber}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  'いいね',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                  TabBar(
                    isScrollable: true,
                    labelColor: Colors.white,
                    unselectedLabelColor: Theme.of(context).primaryColor,
                    indicator: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
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
                  Consumer(builder: (context, watch, _) {
                    return watch(myTalkProvider).isLoading
                        ? Container(
                            height: MediaQuery.of(context).size.height * 1 / 4,
                            alignment: Alignment.bottomCenter,
                            child: const PopTalkCircularProgressIndicator(),
                          )
                        : Container(
                            height: _tabIndex == 0
                                ? widget.draftTalkItems.isEmpty
                                    ? 400
                                    : (175 * widget.draftTalkItems.length)
                                        .toDouble()
                                : widget.publishTalkItems.isEmpty
                                    ? 400
                                    : (195 * widget.publishTalkItems.length)
                                        .toDouble(),
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Consumer(builder: (context, watch, _) {
                              return TabBarView(
                                children: [
                                  widget.draftTalkItems.isEmpty
                                      ? const Center(
                                          child: Text(
                                            '保存済みのトークはまだありません',
                                          ),
                                        )
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              widget.draftTalkItems.length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return TalkTile(
                                              talkItem:
                                                  widget.draftTalkItems[i],
                                              isPublic: false,
                                            );
                                          },
                                        ),
                                  widget.publishTalkItems.isEmpty
                                      ? const Center(
                                          child: Text(
                                            '配信済みのトークはまだありません',
                                          ),
                                        )
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              widget.publishTalkItems.length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return TalkTile(
                                              talkItem:
                                                  widget.publishTalkItems[i],
                                              isPublic: true,
                                            );
                                          },
                                        ),
                                ],
                              );
                            }),
                          );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

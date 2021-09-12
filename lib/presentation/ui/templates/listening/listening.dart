import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/templates/listening/tab_view/following_users_tab_view.dart';
import 'package:pop_talk/presentation/ui/templates/listening/tab_view/liked_talks_tab_view.dart';
import 'package:pop_talk/presentation/ui/templates/listening/tab_view/recommendation_tab_view.dart';

class ListeningTemplate extends StatefulWidget {
  const ListeningTemplate(
      {Key? key,
      required this.recommendLists,
      required this.followLists,
      required this.likeLists})
      : super(key: key);

  final List<TalkItem> recommendLists;
  final List<TalkItem> followLists;
  final List<TalkItem> likeLists;

  @override
  _ListeningTemplateState createState() => _ListeningTemplateState();
}

class _ListeningTemplateState extends State<ListeningTemplate> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: primaryColor,
              border: Border.all(color: primaryColor),
            ),
            onTap: (index) {
              setState(() {});
            },
            tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Tab(
                  text: 'おすすめ',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Tab(
                  text: 'フォロー中',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Tab(
                  text: 'いいね',
                ),
              ),
            ],
          ),
          Expanded(
              child: TabBarView(
            children: [
              const RecommendationTabView(),
              FollowingUsersTabView(followLists: widget.followLists),
              LikedTalksTabView(likeLists: widget.likeLists),
            ],
          ))
        ],
      ),
    );
  }



}

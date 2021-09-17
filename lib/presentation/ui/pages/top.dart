import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:pop_talk/presentation/notifier/player.dart';
import 'package:pop_talk/presentation/ui/pages/listening.dart';
import 'package:pop_talk/presentation/ui/pages/my_talk.dart';
import 'package:pop_talk/presentation/ui/pages/talk.dart';

class TopPage extends StatefulWidget {
  static const routeName = '/top';

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  final _pageList = [
    ListeningPage(),
    TalkPage(),
    const MyTalkPage(),
  ];

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: _pageList[_selectedIndex],
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniPlayer(),
          BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.headphones),
                label: '聞く',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.keyboard_voice),
                label: '話す',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.radio),
                label: 'マイトーク',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final playerNotifier = watch(playerProvider);
      if (playerNotifier.currentTalk != null) {
        final currentTalk = playerNotifier.currentTalk!;
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
              bottom: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            color: Theme.of(context).canvasColor,
          ),
          // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(currentTalk.createdUser.photoUrl),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentTalk.topicName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      currentTalk.createdUser.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  if (playerNotifier.playerButtonState ==
                      PlayerButtonState.playing)
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: InkWell(
                        onTap: playerNotifier.pause,
                        child: FaIcon(
                          FontAwesomeIcons.pause,
                          size: 18,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  if (playerNotifier.playerButtonState ==
                      PlayerButtonState.paused)
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: InkWell(
                        onTap: playerNotifier.play,
                        child: FaIcon(
                          FontAwesomeIcons.play,
                          size: 18,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  Consumer(builder: (context, watch, _) {
                    final _authNotifier = watch(authProvider);
                    final _currentUser = _authNotifier.currentUser!;
                    if (_currentUser.alreadyLikeTalk(currentTalk.id)) {
                      return Icon(
                        Icons.favorite,
                        size: 24,
                        color: Theme.of(context).primaryColor,
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          _authNotifier.likeTalk(currentTalk);
                        },
                        child: Icon(
                          Icons.favorite_border,
                          size: 24,
                          color: Colors.grey[400],
                        ),
                      );
                    }
                  }),
                ],
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

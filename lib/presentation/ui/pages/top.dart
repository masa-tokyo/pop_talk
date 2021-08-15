import 'package:flutter/material.dart';
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
    MyTalkPage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: _pageList[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

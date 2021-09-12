import 'package:flutter/material.dart';

class RecommendationTabView extends StatelessWidget {
  const RecommendationTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              decoration: _decoration(primaryColor),
              child: Column(
                children: [
                  _topicCard(context),
                  _aboutTopicItem(),
                  _audioPlayer(),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _followButton(),
                        const SizedBox(width: 15,),
                        _likeButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          _miniPlayer(),
        ],
      ),
    );
  }

  BoxDecoration _decoration(Color primaryColor) {
    return BoxDecoration(
      border: Border.all(width: 3, color: primaryColor),
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          // changes position of shadow
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _topicCard(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Container(
        height: height * 0.25,
        width: width * 0.75,
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            _userImage(),
            const Center(
              // TODO(any): pass topicName data
              child: Text(
                '面白かったこと',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _userImage() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                      fit: BoxFit.fill,

                      // TODO(any): pass the data about createdUser
                      image:
                          NetworkImage('https://picsum.photos/250?image=9'))),
            ),
            const Text('山田太郎',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }

  Widget _aboutTopicItem() {
    return Column(
      children: const [
        Center(
            child: Text(
          'ヒカルについて',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
          'テキストテキストテキスト',
        )),
      ],
    );
  }

  Widget _audioPlayer() {
    double _currentValue = 45;

    return Column(
      children: [
        Slider(
          value: _currentValue,
          min: 0,
          max: 100,
          label: _currentValue.round().toString(),
          onChanged: (double value) {
            // setState(() {
            //   _currentValue = value.roundToDouble();
            // });
          },
          activeColor: Colors.deepOrangeAccent,
          inactiveColor: Colors.grey[300],
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 50,
                    color: Colors.deepOrangeAccent,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_circle_fill_outlined,
                    size: 50,
                    color: Colors.deepOrangeAccent,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 50,
                    color: Colors.deepOrangeAccent,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _followButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 1, color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        primary: Colors.black,
      ),
      label: const Text('フォロー'),
      icon: const Icon(
        Icons.person_add,
      ),
    );
  }

  Widget _likeButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: OutlinedButton.icon(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 1, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            primary: Colors.black),
        label: const Text('いいね'),
        icon: const Icon(
          Icons.favorite,
        ),
      ),
    );
  }

  // TODO(any): グローバルナビまたいで全箇所（PostRecordingScreen以外)で表示
  Widget _miniPlayer() {
    return Column(
      children: [
        const Divider(
          color: Colors.black26,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            NetworkImage('https://picsum.photos/250?image=9'))),
              ),
              Expanded(
                child: Column(
                  children: const [
                    Text('山田太郎',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Icon(
                      Icons.clear_outlined,
                      color: Color(0xFFBDBDBD),
                      size: 10,
                    ),
                    Text('人生で一番恥ずかしかったこと',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.pause,
                        size: 25,
                        color: Color(0xFFBDBDBD),
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        size: 25,
                        color: Color(0xFFBDBDBD),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';

class TalkDetailPage extends StatelessWidget {
  const TalkDetailPage({
    Key? key,
    required this.talkItem,
  }) : super(key: key);

  final TalkItem talkItem;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30, left: 10),
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 160,
              width: width * 0.90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 50,
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
                  SizedBox(
                    width: width * 0.50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '山田太郎',
                          style: TextStyle(fontSize: 24),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          width: width * 0.90,
          child: Column(
            children: [
              Text(
                talkItem.talkTopic,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Text(
                talkItem.title,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                talkItem.description,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

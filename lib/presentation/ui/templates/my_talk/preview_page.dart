import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/ui/molecules/detail_dialog.dart';
import 'package:pop_talk/presentation/ui/templates/my_talk/existing_talk_edit_page.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({
    Key? key,
    required this.talkItem,
    required this.modalSetState,
  }) : super(key: key);

  final TalkItem talkItem;
  final StateSetter modalSetState;

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

double _currentValue = 50;

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.symmetric(vertical: 8),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
              const Spacer(),
              IconButton(
                padding: const EdgeInsets.symmetric(vertical: 8),
                onPressed: () {
                  // TODO(MyTalkTeam): トークを削除
                },
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  size: 30,
                ),
              ),
            ],
          ),
          Container(
            height: 240,
            constraints: const BoxConstraints(maxWidth: 600),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Color(widget.talkItem.colorCode),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
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
                      ),
                      const Text(
                        '山田太郎',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black26,
                  ),
                  child: Text(
                    widget.talkItem.topicName,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.talkItem.title ?? '無題',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: LayoutBuilder(
              builder: (_, constraints) {
                final descriptionStyle =
                    Theme.of(context).textTheme.headline2!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                        );
                final textSpan = TextSpan(
                  text: widget.talkItem.description,
                  style: descriptionStyle,
                );
                final textPainter = TextPainter(
                  text: textSpan,
                  textDirection: TextDirection.ltr,
                  maxLines: 1,
                )..layout(maxWidth: constraints.maxWidth);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.talkItem.description ?? '',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    textPainter.didExceedMaxLines
                        ? GestureDetector(
                            onTap: () => DetailDialog.show(
                              context: context,
                              talkItem: widget.talkItem,
                            ),
                            child: Text(
                              '詳細',
                              textAlign: TextAlign.end,
                              style: descriptionStyle,
                            ),
                          )
                        : const Text(''),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 60),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Slider(
                  value: _currentValue,
                  min: 0,
                  max: 100,
                  label: _currentValue.round().toString(),
                  onChanged: (double value) {
                    widget.modalSetState(() {
                      _currentValue = value.roundToDouble();
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey[300],
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Row(
                    children: const [
                      Text(
                        '2分30秒',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        '2分30秒',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.play_circle_fill_outlined,
                  size: 120,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showModalBottomSheet(
                        context: context,
                        page: ExisitingTalkEditPage(talkItem: widget.talkItem),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 32,
                        ),
                      ),
                      child: Text(
                        '編集する',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 配信停止 or 配信する
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 32,
                        ),
                      ),
                      child: Text(
                        widget.talkItem.isPublic ? '配信停止' : '配信する',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

void _showModalBottomSheet({
  required BuildContext context,
  required Widget page,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    isScrollControlled: true,
    builder: (context) {
      return page;
    },
  );
}

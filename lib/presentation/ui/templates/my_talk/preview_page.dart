import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/notifier/my_talk.dart';
import 'package:pop_talk/presentation/notifier/player.dart';
import 'package:pop_talk/presentation/ui/molecules/detail_dialog.dart';
import 'package:pop_talk/presentation/ui/templates/my_talk/existing_talk_edit_page.dart';
import 'package:pop_talk/presentation/ui/utils/functions.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({
    Key? key,
    required this.talkItem,
    required this.modalSetState,
    required this.playerNotifier,
  }) : super(key: key);

  final TalkItem talkItem;
  final StateSetter modalSetState;
  final PlayerNotifier playerNotifier;

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final playerNotifier = watch(playerProvider);
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
                    onPressed: () async {
                      await _confirmDialog(
                        context: context,
                        content: 'トークを削除しますか？',
                        talkItem: widget.talkItem,
                        toDelete: true,
                      );
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
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                                child: Image.network(
                                  widget.talkItem.createdUser.photoUrl,
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
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _slider(context, playerNotifier),
                    _playButton(context, playerNotifier),
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => _showModalBottomSheet(
                              context: context,
                              page: ExisitingTalkEditPage(
                                  talkItem: widget.talkItem),
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
                            onPressed: () async {
                              widget.talkItem.isPublic
                                  ? await _confirmDialog(
                                      context: context,
                                      content: 'トークを配信停止にしますか？',
                                      talkItem: widget.talkItem,
                                      toDelete: false,
                                    )
                                  : await _confirmDialog(
                                      context: context,
                                      content: 'トークを配信しますか？',
                                      talkItem: widget.talkItem,
                                      toDelete: false,
                                    );
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
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _slider(BuildContext context, PlayerNotifier playerNotifier) {
    final primaryColor = Theme.of(context).primaryColor;
    final position = playerNotifier.position;
    final duration = playerNotifier.duration;

    return Column(children: [
      Slider(
        value: duration.inSeconds == 0
            ? 0
            : position.inSeconds / duration.inSeconds,
        onChanged: (value) {
          final newPosition = value * duration.inSeconds;
          playerNotifier.seek(newPosition.toInt());
        },
        activeColor: primaryColor,
        inactiveColor: Colors.grey[300],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              convertDurationToString(position),
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline5!.fontSize),
            ),
            Text(
              convertDurationToString(duration),
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline5!.fontSize),
            ),
          ],
        ),
      )
    ]);
  }

  Widget _playButton(BuildContext context, PlayerNotifier playerNotifier) {
    final buttonState = playerNotifier.playerButtonState;
    final primaryColor = Theme.of(context).primaryColor;

    Widget icon;
    switch (buttonState) {
      case PlayerButtonState.loading:
        icon = const SizedBox(
          width: 24,
          height: 24,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
        break;
      case PlayerButtonState.playing:
        icon = const FaIcon(
          FontAwesomeIcons.pause,
          size: 24,
        );
        break;
      case PlayerButtonState.paused:
        icon = const FaIcon(
          FontAwesomeIcons.play,
          size: 24,
        );
    }
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          if (buttonState == PlayerButtonState.paused) {
            playerNotifier.play();
          } else if (buttonState == PlayerButtonState.playing) {
            playerNotifier.pause();
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
            shape: MaterialStateProperty.all(
                CircleBorder(side: BorderSide(color: primaryColor)))),
        child: icon,
      ),
    );
  }

  Future<void> init() async {
    await widget.playerNotifier.initPlayer(
      AudioPlayType.single,
      uri: widget.talkItem.uri,
    );
  }
}

Future<void> _showModalBottomSheet({
  required BuildContext context,
  required Widget page,
}) async {
  await showModalBottomSheet<void>(
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

Future<void> _confirmDialog({
  required BuildContext context,
  required String content,
  required TalkItem talkItem,
  required bool toDelete,
}) async {
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: Colors.white,
          ),
          child: const Text(
            'いいえ',
          ),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black,
            backgroundColor: Colors.white,
          ),
          child: const Text('はい'),
          onPressed: () async {
            toDelete
                ? await context
                    .read(myTalkProvider)
                    .deleteTalkItem(talkItem: talkItem)
                : talkItem.isPublic
                    ? await context
                        .read(myTalkProvider)
                        .draftTalk(talkItem: talkItem)
                    : await context
                        .read(myTalkProvider)
                        .publishTalk(talkItem: talkItem);
            Navigator.of(ctx).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

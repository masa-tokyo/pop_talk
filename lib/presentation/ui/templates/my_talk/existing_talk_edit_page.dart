import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';

class ExisitingTalkEditPage extends StatefulWidget {
  const ExisitingTalkEditPage({
    Key? key,
    required this.talkItem,
  }) : super(key: key);
  final TalkItem talkItem;

  @override
  _ExistingTalkEditPageState createState() => _ExistingTalkEditPageState();
}

class _ExistingTalkEditPageState extends State<ExisitingTalkEditPage> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.talkItem.title);
    final descriptionController =
        TextEditingController(text: widget.talkItem.description);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Text(widget.talkItem.talkTopic,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  'タイトル',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline4!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: titleController,
                  maxLines: 1,
                  maxLength: 40,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: '40字以内で入力してください',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  '説明',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline4!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  maxLength: 800,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText:
                        '例) A子ちゃんとのスタバでのおしゃべりです。とってもゆるい感じですが、よかったら聴いてください笑',
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              // 保存処理
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 40,
              ),
            ),
            child: Text(
              '保存する',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

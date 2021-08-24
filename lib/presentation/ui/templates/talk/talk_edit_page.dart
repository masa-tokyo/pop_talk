import 'package:flutter/material.dart';

class TalkEditPage extends StatefulWidget {
  const TalkEditPage({
    required this.titleController,
    required this.descriptionController,
    required this.onPostButtonPressed,
    required this.onDraftSaveButtonPressed});
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final VoidCallback onPostButtonPressed;
  final VoidCallback onDraftSaveButtonPressed;

  @override
  _TalkEditPageState createState() => _TalkEditPageState();
}

class _TalkEditPageState extends State<TalkEditPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              //todo pass the data of the topic
              Text('最近ハマってるYouTuberは？',
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
                  controller: widget.titleController,
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
                  controller: widget.descriptionController,
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
          Column(
            children: [
              SizedBox(
                width: 260,
                height: 64,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    )),
                  ),
                  onPressed: widget.onPostButtonPressed,
                  child: Text(
                    '配信する',
                    style: TextStyle(
                        fontSize:
                        Theme.of(context).textTheme.headline2!.fontSize),
                  ),
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
                  onPressed: widget.onDraftSaveButtonPressed,
                  child: Text(
                    '下書き保存する',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize:
                        Theme.of(context).textTheme.bodyText1!.fontSize),
                  )),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ],
      ),
    );

  }
}

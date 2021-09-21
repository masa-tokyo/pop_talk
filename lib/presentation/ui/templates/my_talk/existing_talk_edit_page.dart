import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/domain/model/talk_item.dart';
import 'package:pop_talk/presentation/notifier/my_talk.dart';

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
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.talkItem.title ?? '';
    _descriptionController.text = widget.talkItem.description ?? '';
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    Text(widget.talkItem.topicName,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline2!.fontSize,
                        )),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'タイトル',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline4!.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      controller: _titleController,
                      maxLines: 1,
                      maxLength: 40,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: '40字以内で入力してください',
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.trim().isEmpty) {
                          return 'タイトルを入力してください';
                        }
                      },
                      onChanged: (_) {
                        if (_form.currentState!.validate()) {
                          _form.currentState!.save();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      '説明',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline4!.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      maxLength: 800,
                      keyboardType: TextInputType.text,
                      focusNode: _descriptionFocusNode,
                      decoration: const InputDecoration(
                        hintText:
                            '例) A子ちゃんとのスタバでのおしゃべりです。とってもゆるい感じですが、よかったら聴いてください笑',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer(builder: (_, watch, __) {
            return TextButton(
              onPressed: () async {
                if (_form.currentState!.validate()) {
                  await watch(myTalkProvider).editTalk(
                    talkItem: widget.talkItem,
                    newTitle: _titleController.text,
                    newDescription: _descriptionController.text,
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
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
            );
          }),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}

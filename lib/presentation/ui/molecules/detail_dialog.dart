import 'package:flutter/material.dart';
import 'package:pop_talk/domain/model/talk_item.dart';

class DetailDialog extends StatelessWidget {
  const DetailDialog({Key? key, required this.talkItem}) : super(key: key);
  static void show(
      {required BuildContext context, required TalkItem talkItem}) {
    showDialog<void>(
      context: context,
      builder: (context) => DetailDialog(talkItem: talkItem),
    );
  }

  final TalkItem talkItem;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                size: 30,
              ),
            ),
          ),
          SizedBox(
            height: 180,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                child: Text(
                  talkItem.description ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

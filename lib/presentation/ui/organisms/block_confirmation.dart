import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlockConfirmation extends StatelessWidget {
  const BlockConfirmation(
      {Key? key, required this.talkId, required this.userId})
      : super(key: key);

  final String talkId;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'ユーザーをブロックしますか？',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'このユーザーのトークは表示されなくなります',
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(
                  FontAwesomeIcons.userSlash,
                  color: Colors.red,
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () async{
                    final authNotifier = context.read(authProvider);
                    await authNotifier.blockUser(userId);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ユーザーをブロック',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
              ),
              child: const Text('キャンセルする'),
            ),
          ],
        ),
      ),
    );
  }
}

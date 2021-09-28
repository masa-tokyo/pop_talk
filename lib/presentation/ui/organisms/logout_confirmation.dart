import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pop_talk/presentation/notifier/auth.dart';

class LogoutConfirmation extends ConsumerWidget {
  const LogoutConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SizedBox(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            padding: const EdgeInsets.only(left: 8),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              size: 30,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'ログアウトしますか？',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await watch(authProvider).signOut();
                    Navigator.of(context).pop();
                  },
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
                  child: const Text('ログアウト'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
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
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black12,
                      child: FaIcon(
                        FontAwesomeIcons.ban,
                        color: Colors.black45,
                      ),
                    ),
                    Text('ブロック'),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black12,
                      child: FaIcon(
                        FontAwesomeIcons.exclamationTriangle,
                        color: Colors.black45,
                      ),
                    ),
                    Text('通報'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

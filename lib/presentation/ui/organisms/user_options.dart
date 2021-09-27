import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pop_talk/presentation/ui/organisms/block_confirmation.dart';
import 'package:pop_talk/presentation/ui/templates/listening/report_page.dart';
import 'package:pop_talk/presentation/ui/utils/modal_bottom_sheet.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
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
            padding: const EdgeInsets.only(left: 20, top: 16),
            child: Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    Navigator.of(context).pop();
                    await showBottomSheetPage(
                      context: context,
                      page: BlockConfirmation(
                        userId: userId,
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black12,
                        child: FaIcon(
                          FontAwesomeIcons.userSlash,
                          color: Colors.black45,
                        ),
                      ),
                      Text('ブロック'),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    await Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext _context) =>
                            ReportPage(userId: userId),
                      ),
                    );
                  },
                  child: Column(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

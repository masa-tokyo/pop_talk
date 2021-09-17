import 'package:flutter/material.dart';

Future<void> showBottomSheetPage({
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

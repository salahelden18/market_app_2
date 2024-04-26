import 'package:flutter/material.dart';

Future<void> showModalSheet(BuildContext context, Widget widget) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(),
    showDragHandle: true,
    context: context,
    builder: (ctx) => widget,
  );
}

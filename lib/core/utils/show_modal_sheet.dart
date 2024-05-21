import 'package:flutter/material.dart';

Future<void> showModalSheet(BuildContext context, Widget widget) async {
  await showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    showDragHandle: true,
    context: context,
    builder: (ctx) => widget,
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> showModalSheet(BuildContext context, Widget widget) async {
  await showModalBottomSheet(
    shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(30),
    )),
    showDragHandle: true,
    context: context,
    builder: (ctx) => widget,
  );
}

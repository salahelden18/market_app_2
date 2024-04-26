import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/app_colors.dart';

enum MessageType { success, error, warning }

void showToast({
  required BuildContext context,
  required String msg,
  MessageType messageType = MessageType.error,
  Toast toastLength = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.BOTTOM,
}) {
  Color? color;
  switch (messageType) {
    case MessageType.success:
      color = AppColors.successColor;
      break;
    case MessageType.error:
      color = AppColors.errorColor;
      break;
    case MessageType.warning:
      color = AppColors.warningColor;
      break;
    default:
      color = Colors.black;
      break;
  }

  Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
  );
}

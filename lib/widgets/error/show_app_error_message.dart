import 'package:flutter/material.dart';
import 'package:make_friends_app/widgets/error/show_snack_bar.dart';

void showAppErrorMessage({
  required BuildContext context,
  required dynamic e,
  String? message,
}) {
  String? _message;

  if (message != null) {
    _message = message;
  } else if (e != null && e.toString().contains('The request timed out')) {
    _message = "通信エラーが発生しました。電波状態の良いところで再度お試しください。";
  } else {
    _message = '問題が発生したため、操作を完了できませんでした。しばらくしてから再度お試しください。';
  }

  showSnackBar(context: context, message: _message);
}

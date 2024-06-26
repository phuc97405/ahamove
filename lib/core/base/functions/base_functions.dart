import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahamove/core/constants/app/color_constant.dart';

class BaseFunctions {
  static BaseFunctions? _instance;
  static BaseFunctions get instance {
    _instance ??= BaseFunctions._init();
    return _instance!;
  }

  BaseFunctions._init();

  Widget platformIndicator() {
    return Center(
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : CircularProgressIndicator(
              color: ColorConstants.instance.primary,
            ),
    );
  }

  IconButton platformBackButton({
    required VoidCallback onPressed,
    Color? color = Colors.black,
  }) {
    return Platform.isIOS
        ? IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_back_ios,
              color: color,
            ),
          )
        : IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_back,
              color: color,
            ),
          );
  }

  String formatNumberToK(int number) {
    if (number < 1000) {
      return number.toString();
    }
    String numStr = number.toString();
    final regex = RegExp(r'^(\d+)(\d{3})$');
    return numStr.replaceAllMapped(regex, (match) {
      return '${match.group(1)}.${match.group(2)![0]}k';
    });
  }

  void showDialogView(
      {required BuildContext context, required Widget content}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(content: content);
      },
    );
  }
}

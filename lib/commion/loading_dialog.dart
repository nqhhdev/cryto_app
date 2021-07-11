import 'package:crypto_app_project/config/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingDialog {
  static void get hideLoadingDialog {
    Navigator.of(NavigationUtil.currentContext!).pop();
  }

  static void showLoadingDialog(BuildContext context) {
    final alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

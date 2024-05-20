import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, Color c) {
  final snackBar = SnackBar(
    content: Text(text),
    backgroundColor: c,
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'OK',
      disabledTextColor: Colors.white,
      textColor: Colors.white,
      onPressed: () {
        //Do whatever you want
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

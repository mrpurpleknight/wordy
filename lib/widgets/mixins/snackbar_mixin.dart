import 'package:flutter/material.dart';

mixin SnackBarMixin<T> {
  static bool isVisible = false;

  void showSnackBar(String text, BuildContext context) {
    if (!isVisible) {
      isVisible = true;
      Scaffold.of(context).showSnackBar(
        SnackBar(
          key: Key(text),
          duration: const Duration(seconds: 3),
          content: Text(
            text,
            style: const TextStyle(
              color: Colors.amberAccent,
              fontSize: 15,
            ),
          ),
        ),
      );
      Future.delayed(Duration(seconds: 2)).then((value) => isVisible = false);
    }
  }
}

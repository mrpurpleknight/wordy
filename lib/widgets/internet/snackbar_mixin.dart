import 'package:flutter/material.dart';


mixin SnackBarMixin<T extends StatefulWidget> on State<T> {
  void showSnackBar(String text, BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          text,
          style: TextStyle(
            color: Colors.amberAccent,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

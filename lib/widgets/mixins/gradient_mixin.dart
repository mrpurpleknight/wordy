import 'package:flutter/cupertino.dart';

mixin GradientMixin<T extends StatefulWidget> on State<T> {
  LinearGradient getLinearGradient(List<Color> orderedColorsList) {
    return LinearGradient(
        colors: orderedColorsList,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
  }
}
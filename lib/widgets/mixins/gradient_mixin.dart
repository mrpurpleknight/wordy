import 'package:flutter/cupertino.dart';

mixin GradientMixin<T> {
  LinearGradient getLinearGradient(List<Color> orderedColorsList) {
    return LinearGradient(
        colors: orderedColorsList,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
  }
}
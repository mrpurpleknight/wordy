import 'package:flutter/material.dart';
import 'package:wordy/widgets/mixins/gradient_mixin.dart';

import '../../constants.dart';

abstract class AbstractDetailScreen extends StatefulWidget{
  AbstractDetailScreen({Key key}) : super(key: key);
}

abstract class AbstractDetailScreenState<T extends StatefulWidget> extends State<T> with GradientMixin {

  BoxDecoration getContainerDecoration() {
    return BoxDecoration(
      gradient:
      getLinearGradient([gradientBegin, gradientMed, gradientEnd]),
    );
  }

  Column getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...getChildren(),
      ],
    );
  }

  List<Widget> getChildren();
}
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_words/screens/main_screen.dart';
import 'package:learn_words/screens/random_word_page_view.dart';
import 'package:learn_words/screens/random_word_screen.dart';

class WordPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        MainScreen(),
        RandomWordPageView(),
      ],
    );
  }
}

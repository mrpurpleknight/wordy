import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_words/providers/word.dart';
import 'package:learn_words/providers/words.dart';
import 'package:learn_words/screens/main_screen.dart';
import 'package:learn_words/screens/random_word_page_view.dart';
import 'package:learn_words/screens/random_word_screen.dart';
import 'package:provider/provider.dart';

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Words.instance,
        ),
      ],
      child: PageView(
        scrollDirection: Axis.vertical,
        children: [
          MainScreen(),
          RandomWordPageView(),
        ],
      ),
    );
  }
}

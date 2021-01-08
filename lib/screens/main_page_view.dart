import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordy/providers/suggestions.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/screens/main_screen.dart';
import 'package:wordy/screens/random_word_page_view.dart';
import 'package:wordy/screens/random_word_screen.dart';
import 'package:provider/provider.dart';

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Words.instance,
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

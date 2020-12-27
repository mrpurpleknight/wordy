import 'package:flutter/material.dart';
import 'package:learn_words/screens/random_word_screen.dart';
import 'package:learn_words/widgets/word_tile.dart';

class RandomWordPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: PageController(keepPage: true),
        scrollDirection: Axis.vertical,
        itemCount: 500,
        itemBuilder: (context, index) {
          return RandomWordScreen();
        });
  }
}

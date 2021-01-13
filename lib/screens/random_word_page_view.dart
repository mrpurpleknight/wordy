import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/random_word_screen.dart';

class RandomWordPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: PageController(keepPage: true, viewportFraction: 1.1),
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.down,
        itemBuilder: (context, index) {
          return RandomWordScreen();
        });
  }
}

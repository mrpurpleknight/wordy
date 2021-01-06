import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wordy/business/words_manager.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/random_word_screen.dart';
import 'package:provider/provider.dart';

class RandomWordPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: PageController(keepPage: true),
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.down,
        itemBuilder: (context, index) {
          return Provider(
            create: (_) => Word.random(),
            child: RandomWordScreen(),
            lazy: false,
          );
        });
  }
}

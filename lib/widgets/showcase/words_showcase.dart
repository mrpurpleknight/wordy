import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/words/word_tile_small.dart';

class WordsShowcase extends StatelessWidget {

  final List<Word> _words;

  WordsShowcase(this._words);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ..._words.map((e) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 11),
              child: SmallWordTile(e),
            );
          }),
        ],
      ),
    );
  }
}

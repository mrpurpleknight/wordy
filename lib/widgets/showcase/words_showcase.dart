import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/words/word_tile_small.dart';

class WordsShowcase extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Words words = Provider.of<Words>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...words.getLast5Word().map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 11),
              child: SmallWordTile(e),
            );
          }),
        ],
      ),
    );
  }
}

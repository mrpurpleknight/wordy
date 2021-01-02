import 'package:flutter/material.dart';
import 'package:learn_words/providers/words.dart';
import 'package:learn_words/widgets/word_tile_small.dart';
import 'package:provider/provider.dart';

class WordsShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Words words = Provider.of<Words>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...words.getLast5Word().map((e) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: SmallWordTile(e),
            );
          }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:learn_words/constants.dart';
import 'package:learn_words/providers/words.dart';
import 'package:learn_words/widgets/word_tile_small.dart';
import 'package:provider/provider.dart';

class WordsGrid extends StatefulWidget {
  @override
  _WordsGridState createState() => _WordsGridState();
}

class _WordsGridState extends State<WordsGrid> {
  @override
  Widget build(BuildContext context) {
    Words words = Provider.of<Words>(context);
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.675),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: SmallWordTile(words.getList().elementAt(index)),
          );
        },
        childCount: words.getList().length,
      ),
    );
  }
}

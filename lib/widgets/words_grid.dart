import 'package:flutter/material.dart';
import 'package:wordy/constants.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/word_tile_small.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: SmallWordTile(words.getList().elementAt(index)),
          );
        },
        childCount: words.getList().length,
      ),
    );
  }
}

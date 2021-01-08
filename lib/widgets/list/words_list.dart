import 'package:flutter/material.dart';
import 'package:wordy/constants.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/list/word_list_tile.dart';
import 'package:wordy/widgets/word_tile_small.dart';
import 'package:provider/provider.dart';

class WordsList extends StatefulWidget {
  @override
  _WordsListState createState() => _WordsListState();
}

class _WordsListState extends State<WordsList> {
  @override
  Widget build(BuildContext context) {
    Words words = Provider.of<Words>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            child: WordListTile(words.sortByName().elementAt(index)),
          );
        },
        childCount: words.sortByName().length,
      ),
    );
  }
}

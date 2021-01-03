import 'package:flutter/material.dart';
import 'package:learn_words/providers/word.dart';
import 'package:learn_words/widgets/search/suggestion_tile.dart';

class SuggestionsList extends StatelessWidget {
  final List<Word> words;

  SuggestionsList(this.words);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: words.length,
        itemBuilder: (context, index) {
          return SuggestionTile(words.elementAt(index));
        });
  }
}

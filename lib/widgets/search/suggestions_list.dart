import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/search/suggestion_tile.dart';

class SuggestionsList extends StatelessWidget {
  final List<Word> words;
  final TextEditingController controller;

  SuggestionsList(this.words, {this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: words.length,
        itemBuilder: (context, index) {
          return SuggestionTile(words.elementAt(index), controller: controller);
        });
  }
}

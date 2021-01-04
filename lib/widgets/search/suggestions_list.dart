import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/search/suggestion_tile.dart';

class SuggestionsList extends StatelessWidget {
  final List<Word> words;
  final TextEditingController controller;
  final Function refreshInputCallback;

  SuggestionsList(this.words, {this.controller, this.refreshInputCallback});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: words.length,
          itemBuilder: (context, index) {
            return SuggestionTile(words.elementAt(index), controller: controller, refreshInputCallback: refreshInputCallback);
          }),
    );
  }
}

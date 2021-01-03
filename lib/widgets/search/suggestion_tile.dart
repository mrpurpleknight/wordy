import 'package:flutter/material.dart';
import 'package:learn_words/providers/word.dart';
import 'package:learn_words/screens/word_detail_screen.dart';

class SuggestionTile extends StatelessWidget {
  final Word _word;

  SuggestionTile(this._word);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(WordDetailScreen.routeName, arguments: _word),
      child: ListTile(
        title: Row(
          children: [
            Text(
              _word.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Text(
                '[${_word.partOfSpeechAbbreviation}.]',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.search),
      ),
    );
  }
}

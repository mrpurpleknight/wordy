import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordy/providers/search_bar_status.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/word_detail_screen.dart';

class SuggestionTile extends StatelessWidget {
  final Word _word;

  SuggestionTile(this._word);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<SearchBarStatus>(context, listen: false).refreshInput();
        Navigator.of(context)
            .pushNamed(WordDetailScreen.routeName, arguments: _word);
      },
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
                '[${_word.partOfSpeechAbbreviation}]',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Icon(
            Icons.search,
            size: 30,
            color: Theme.of(context).backgroundColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/word_detail_screen.dart';

class SuggestionTile extends StatelessWidget {
  final Word _word;
  final TextEditingController controller;

  SuggestionTile(this._word, {this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }

        controller.text = '';

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
        trailing: Icon(
          Icons.search,
          size: 30,
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}

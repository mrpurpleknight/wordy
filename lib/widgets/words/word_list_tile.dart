import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/word_detail_screen.dart';

class WordListTile extends StatelessWidget {
  final Word _word;

  WordListTile(this._word);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(WordDetailScreen.routeName, arguments: _word),
      child: Container(
        alignment: Alignment.center,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black45, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: ListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  _word.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  '[${_word.partOfSpeechAbbreviation}]',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          trailing: Icon(
            Icons.more_vert,
            size: 32,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/word_detail_screen.dart';
import 'package:wordy/widgets/abstract/abstract_tile.dart';

class WordListTile extends AbstractTile {
  final Word _word;

  WordListTile(this._word);

  @override
  _WordListTileState createState() => _WordListTileState();
}

class _WordListTileState extends AbstractTileState<WordListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(WordDetailScreen.routeName, arguments: widget._word),
      child: Container(
        alignment: Alignment.center,
        height: 70,
        decoration: getContainerDecoration(1.7, Offset(1, 3)),
        child: ListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget._word.name,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  '[${widget._word.partOfSpeechAbbreviation}]',
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

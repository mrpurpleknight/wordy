import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/word_detail_screen.dart';
import 'package:wordy/widgets/abstract/abstract_tile.dart';

class SmallWordTile extends AbstractTile {
  final Word _word;

  SmallWordTile(this._word);

  @override
  _SmallWordTileState createState() => _SmallWordTileState();
}

class _SmallWordTileState extends AbstractTileState<SmallWordTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(WordDetailScreen.routeName, arguments: widget._word),
      child: Container(
        padding:
            const EdgeInsets.only(top: 30, right: 19, left: 19, bottom: 23),
        height: size.height * 0.359,
        width: size.width * 0.5,
        decoration: getContainerDecoration(1.5, Offset(1, 3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget._word.name,
                style: Theme.of(context).textTheme.headline1),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: Text(
                widget._word.partOfSpeech,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Text(
                '1. ${widget._word.definition}',
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/word_detail_screen.dart';

class SmallWordTile extends StatelessWidget {
  final Word _word;

  SmallWordTile(this._word);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(WordDetailScreen.routeName, arguments: _word),
      child: Container(
        padding: const EdgeInsets.only(top: 30, right: 19, left: 19, bottom: 23),
        height: size.height * 0.359,
        width: size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.black38, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(1, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_word.name, style: Theme.of(context).textTheme.headline1),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: Text(
                _word.partOfSpeech,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Text(
                '1. ${_word.definition}',
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

import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/word_detail_screen.dart';

class SmallWordTile extends StatelessWidget {
  final Word word;

  SmallWordTile(this.word);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(WordDetailScreen.routeName, arguments: word),
      child: Container(
        padding: EdgeInsets.only(top: 30, right: 20, left: 19, bottom: 23),
        height: size.height * 0.359,
        width: size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(1, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(word.name, style: Theme.of(context).textTheme.headline1),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                word.partOfSpeech,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 17),
              child: Text(
                '1. ${word.definition}',
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

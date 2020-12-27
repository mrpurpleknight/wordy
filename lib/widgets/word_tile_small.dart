import 'package:flutter/material.dart';
import 'package:learn_words/providers/http_words.dart';
import 'package:learn_words/providers/word.dart';

class SmallWordTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 30, right: 23, left: 22, bottom: 23),
      height: size.height * 0.359,
      width: size.width * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: FutureBuilder<Word>(
          future: HttpWords.instance.randomWord,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center();
            else
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(snapshot.data.name,
                      style: Theme.of(context).textTheme.headline1),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      snapshot.data.partOfSpeech,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 17),
                    child: Text(
                      '1. ${snapshot.data.definition}',
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  )
                ],
              );
          }),
    );
  }
}

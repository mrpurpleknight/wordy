import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wordy/providers/word.dart';

class WordTile extends StatelessWidget {
  final Word _word;

  WordTile(this._word);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 50, right: 25, left: 25, bottom: 25),
      height: size.height * 0.6,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(2, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_word.name, style: Theme.of(context).textTheme.headline2),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 17),
            child: Text(
              _word.partOfSpeech,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 35),
            child: TyperAnimatedTextKit(
              text: [
                '1. ${_word.definition}',
              ],
              textStyle: Theme.of(context).textTheme.headline3,
              repeatForever: false,
              speed: Duration(milliseconds: 35),
              totalRepeatCount: 1,
            ),
          ),
          (_word.examplePhrase == null)
              ? Text('')
              : TyperAnimatedTextKit(
                  text: [
                    _word.examplePhrase,
                  ],
                  textStyle: Theme.of(context).textTheme.headline4,
                  repeatForever: false,
                  speed: Duration(milliseconds: 40),
                  totalRepeatCount: 1,
                )
        ],
      ),
    );
  }
}

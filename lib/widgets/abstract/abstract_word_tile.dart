import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';

import 'abstract_tile.dart';

abstract class AbstractWordTile extends AbstractTile {
  AbstractWordTile({Key key}) : super(key: key);
}

abstract class AbstractWordTileState<T extends AbstractTile>
    extends AbstractTileState<T> {
  Widget getContainer(
      {@required Widget child,
      @required EdgeInsets padding,
      @required double height,
      @required double width}) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration: super.getContainerDecoration(1.7, Offset(2, 4)),
      child: child,
    );
  }

  Widget getTileLayout(Word word) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(word.name, style: Theme.of(context).textTheme.headline2),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 17),
          child: Text(
            word.partOfSpeech,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 35),
          child: TyperAnimatedTextKit(
            text: [
              word.definition,
            ],
            textStyle: Theme.of(context).textTheme.headline3,
            repeatForever: false,
            speed: const Duration(milliseconds: 35),
            totalRepeatCount: 1,
          ),
        ),
        (word.examplePhrase == null)
            ? const Text('')
            : TyperAnimatedTextKit(
                text: [
                  word.examplePhrase,
                ],
                textStyle: Theme.of(context).textTheme.headline4,
                repeatForever: false,
                speed: const Duration(milliseconds: 40),
                totalRepeatCount: 1,
              )
      ],
    );
  }
}

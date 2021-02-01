import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/abstract/abstract_word_tile.dart';

class WordDetailTile extends AbstractWordTile {
  final Word _word;

  WordDetailTile(this._word, {Key key}) : super(key: key);

  @override
  createState() => _WordDetailTileState();
}

class _WordDetailTileState extends AbstractWordTileState<WordDetailTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height * 0.63;
    double width = size.height * 0.9;
    EdgeInsets padding =
        const EdgeInsets.only(top: 50, right: 25, left: 25, bottom: 25);

    return getContainer(
      height: height,
      width: width,
      padding: padding,
      child: getTileLayout(widget._word),
    );
  }
}

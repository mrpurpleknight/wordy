import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/abstract/abstract_toolbar.dart';

class DetailToolbar extends AbstractToolbar {
  final Word _word;

  DetailToolbar(this._word);

  @override
  _DetailToolBarState createState() => _DetailToolBarState();
}

class _DetailToolBarState extends AbstractToolbarState<DetailToolbar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setColor(widget._word);
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.6, top: 10),
      child: getButton(widget._word),
    );
  }
}

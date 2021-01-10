import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/abstract/abstract_detail_screen.dart';
import 'package:wordy/widgets/words/word_tile.dart';
import 'package:wordy/widgets/tool_bar.dart';

class RandomWordScreen extends AbstractDetailScreen {
  @override
  _RandomWordScreenState createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends AbstractDetailScreenState<RandomWordScreen>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  List<Widget> getChildren() {
    return [
      Padding(
        padding:
        const EdgeInsets.only(top: 55, left: 40, right: 40, bottom: 25),
        child: WordTile(),
      ),
      ToolBar(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        decoration: getContainerDecoration(),
        child: Provider(
          create: (_) => Word.random(),
          child: getContent(),
        ),
      ),
    );
  }
}

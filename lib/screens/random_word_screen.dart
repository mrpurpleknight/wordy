import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordy/constants.dart';
import 'package:wordy/widgets/word_tile.dart';
import 'package:wordy/widgets/tool_bar.dart';

class RandomWordScreen extends StatefulWidget {
  @override
  _RandomWordScreenState createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends State<RandomWordScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientBegin, gradientMed, gradientEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 40, right: 40, bottom: 25),
              child: WordTile(),
            ),
            ToolBar(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

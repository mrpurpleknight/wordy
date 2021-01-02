import 'package:flutter/material.dart';
import 'package:learn_words/constants.dart';
import 'package:learn_words/widgets/random_word_tile.dart';
import 'package:learn_words/widgets/tool_bar.dart';

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
              colors: [gradientBegin, gradientMed, gradientEnd ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 25),
              child: RandomWordTile(),
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

import 'package:flutter/material.dart';
import 'package:learn_words/constants.dart';
import 'package:learn_words/business/http_words.dart';
import 'package:learn_words/providers/word.dart';
import 'package:learn_words/providers/words.dart';
import 'package:learn_words/screens/random_word_page_view.dart';
import 'package:learn_words/widgets/random_word_tile.dart';
import 'package:learn_words/widgets/tool_bar.dart';
import 'package:provider/provider.dart';

class RandomWordScreen extends StatefulWidget {
  @override
  _RandomWordScreenState createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends State<RandomWordScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientBegin, gradientEnd],
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

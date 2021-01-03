import 'package:flutter/material.dart';
import 'package:learn_words/providers/word.dart';
import 'package:learn_words/providers/words.dart';
import 'package:learn_words/widgets/tool_bar.dart';
import 'package:learn_words/widgets/word_tile.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class WordDetailScreen extends StatelessWidget {
  static final routeName = '/word-detail';

  @override
  Widget build(BuildContext context) {
    final word = ModalRoute.of(context).settings.arguments as Word;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientBegin, gradientMed, gradientEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: Words.instance),
            Provider.value(
              value: Future.sync(() => word),
            )
          ],
          child: Padding(
            padding: const EdgeInsets.only(bottom: 62),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, left: 40, right: 40, bottom: 25),
                  child: WordTile(word),
                ),
                ToolBar(word),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

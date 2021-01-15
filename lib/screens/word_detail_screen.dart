import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/toolbar/detail_toolbar.dart';
import 'package:wordy/widgets/mixins/gradient_mixin.dart';
import 'package:wordy/widgets/toolbar/random_toolbar.dart';
import 'package:wordy/widgets/words/detail_word_tile.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class WordDetailScreen extends StatefulWidget {
  static final routeName = '/word-detail';

  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen>
    with GradientMixin {
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
          gradient:
              getLinearGradient([gradientBegin, gradientMed, gradientEnd]),
        ),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: Words.instance),
            Provider.value(value: Future.sync(() => word)),
          ],
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, bottom: 25, top: 20),
                  child: WordDetailTile(word),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: DetailToolbar(word),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

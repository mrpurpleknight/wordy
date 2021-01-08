import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/tool_bar.dart';
import 'package:wordy/widgets/words/word_tile.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class WordDetailScreen extends StatelessWidget {
  static final routeName = '/word-detail';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final word = ModalRoute.of(context).settings.arguments as Word;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientBegin, gradientMed, gradientEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: Words.instance),
            Provider.value(value: Future.sync(() => word)),
          ],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, bottom: 25, top: 35),
                    child: WordTile(),
                  ),
                  ToolBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

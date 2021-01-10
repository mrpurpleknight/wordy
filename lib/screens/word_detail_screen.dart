import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/abstract/abstract_detail_screen.dart';
import 'package:wordy/widgets/tool_bar.dart';
import 'package:wordy/widgets/words/word_tile.dart';
import 'package:provider/provider.dart';


class WordDetailScreen extends AbstractDetailScreen {
  static final routeName = '/word-detail';

  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState
    extends AbstractDetailScreenState<WordDetailScreen> {
  @override
  List<Widget> getChildren() {
    return [
      Padding(
        padding: const EdgeInsets.only(
          left: 40,
          right: 40,
          bottom: 25,
        ),
        child: WordTile(),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: ToolBar(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final word = ModalRoute.of(context).settings.arguments as Word;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: Container(
        decoration: getContainerDecoration(),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: Words.instance),
            Provider.value(value: Future.sync(() => word)),
          ],
          child: getContent(),
        ),
      ),
    );
  }
}

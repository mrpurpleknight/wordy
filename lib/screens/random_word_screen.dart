import 'package:flutter/material.dart';
import 'package:learn_words/constants.dart';
import 'package:learn_words/providers/http_words.dart';
import 'package:learn_words/providers/word.dart';
import 'package:learn_words/screens/random_word_page_view.dart';
import 'package:learn_words/widgets/word_tile.dart';
import 'package:provider/provider.dart';

class RandomWordScreen extends StatefulWidget{
  @override
  _RandomWordScreenState createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends State<RandomWordScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientBegin, gradientEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Provider<Future<Word>>(
          create: (_) => Word.random(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: WordTile(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

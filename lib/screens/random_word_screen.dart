import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordy/providers/connectivity_service.dart';
import 'package:wordy/providers/random_word_manager.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/mixins/gradient_mixin.dart';
import 'package:wordy/widgets/words/random_word_tile.dart';
import 'package:wordy/widgets/toolbar/random_toolbar.dart';

import '../constants.dart';

class RandomWordScreen extends StatefulWidget {
  @override
  _RandomWordScreenState createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends State<RandomWordScreen>
    with AutomaticKeepAliveClientMixin, GradientMixin {
  Future<Word> _futureWord;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ConnectivityService service = Provider.of<ConnectivityService>(context);
    if (service.actualState == ConnectivityStatus.on)
      _futureWord = RandomWordManager.instance.getRandomWord();
    return Scaffold(
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
            gradient: getLinearGradient(
                [gradientBegin, gradientMed, gradientEnd]),
          ),
          child: Provider.value(
            value: _futureWord,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 45, left: 40, right: 40, bottom: 25),
                    child: RandomWordTile(),
                  ),
                  RandomToolbar(),
                ],
              ),
            ),
          ),
        ));
  }
}

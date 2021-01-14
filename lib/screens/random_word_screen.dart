import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordy/providers/connectivity_status.dart';
import 'package:wordy/providers/random_word_manager.dart';
import 'package:wordy/widgets/mixins/gradient_mixin.dart';
import 'package:wordy/widgets/words/word_tile.dart';
import 'package:wordy/widgets/tool_bar.dart';

import '../constants.dart';

class RandomWordScreen extends StatefulWidget {
  @override
  _RandomWordScreenState createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends State<RandomWordScreen>
    with AutomaticKeepAliveClientMixin, GradientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient:
              getLinearGradient([gradientBegin, gradientMed, gradientEnd]),
        ),
        child: MultiProvider(
          providers: [
            Provider(
              create: (_) => RandomWordManager.instance.getRandomWord(),
              lazy: false,
            ),
            Provider(
              create: (_) => ConnectivityStatus(),
            ),
          ],
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 55, left: 40, right: 40, bottom: 25),
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

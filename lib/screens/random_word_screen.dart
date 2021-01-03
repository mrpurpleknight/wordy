import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learn_words/constants.dart';
import 'package:learn_words/providers/word.dart';
import 'package:learn_words/widgets/word_tile.dart';
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
    Future<Word> wordFuture = Provider.of<Future<Word>>(context, listen: false);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientBegin, gradientMed, gradientEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: FutureBuilder<Word>(
            future: wordFuture,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (snapshot.connectionState == ConnectionState.waiting)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 40, right: 40, bottom: 25),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 50, right: 25, left: 25, bottom: 25),
                            height: size.height * 0.6,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                      2, 4), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: SpinKitWave(
                              color: Colors.black.withOpacity(0.7),
                              type: SpinKitWaveType.center,
                              size: 35.0,
                            )),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 40, right: 40, bottom: 25),
                          child: WordTile(snapshot.data),
                        ),
                  ToolBar(snapshot.data),
                ],
              );
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

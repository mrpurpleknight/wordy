import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wordy/providers/connectivity_service.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/abstract/abstract_tile.dart';
import 'package:wordy/widgets/mixins/snackbar_mixin.dart';

class WordTile extends AbstractTile {
  @override
  _WordTileState createState() => _WordTileState();
}

class _WordTileState extends AbstractTileState<WordTile> with SnackBarMixin {
  Future<Word> futureWord;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ConnectivityService service = Provider.of<ConnectivityService>(context);
    print(service.actualState);
    if (service.actualState == ConnectivityStatus.on) {

      futureWord = Provider.of<Future<Word>>(context);
      return Container(
        padding:
            const EdgeInsets.only(top: 50, right: 25, left: 25, bottom: 25),
        height: size.height * 0.63,
        width: size.width * 0.9,
        decoration: getContainerDecoration(1.7, Offset(2, 4)),
        child: FutureBuilder<Word>(
            future: futureWord,
            builder: (context, snapshot) {
              if (snapshot.hasError ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitWave(
                    color: Colors.black.withOpacity(0.7),
                    type: SpinKitWaveType.center,
                    size: 35.0,
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data.name,
                        style: Theme.of(context).textTheme.headline2),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 17),
                      child: Text(
                        snapshot.data.partOfSpeech,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 35),
                      child: TyperAnimatedTextKit(
                        text: [
                          '1. ${snapshot.data.definition}',
                        ],
                        textStyle: Theme.of(context).textTheme.headline3,
                        repeatForever: false,
                        speed: const Duration(milliseconds: 35),
                        totalRepeatCount: 1,
                      ),
                    ),
                    (snapshot.data.examplePhrase == null)
                        ? const Text('')
                        : TyperAnimatedTextKit(
                            text: [
                              snapshot.data.examplePhrase,
                            ],
                            textStyle: Theme.of(context).textTheme.headline4,
                            repeatForever: false,
                            speed: const Duration(milliseconds: 40),
                            totalRepeatCount: 1,
                          )
                  ],
                );
              }
            }),
      );
    } else {
      print('allora ci entri');
      return Center();
    }
  }
}

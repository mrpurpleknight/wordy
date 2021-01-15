import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wordy/providers/connectivity_service.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/abstract/abstract_tile.dart';
import 'package:wordy/widgets/abstract/abstract_word_tile.dart';
import 'package:wordy/widgets/mixins/snackbar_mixin.dart';
import 'package:wordy/widgets/words/detail_word_tile.dart';

class RandomWordTile extends AbstractWordTile {
  @override
  _WordTileState createState() => _WordTileState();
}

class _WordTileState extends AbstractWordTileState<RandomWordTile>
    with SnackBarMixin {
  Future<Word> _newFuture;
  Future<Word> _oldFuture;

  Widget loadingState() {
    return Center(
      child: SpinKitWave(
        color: Colors.black.withOpacity(0.7),
        type: SpinKitWaveType.center,
        size: 35.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ConnectivityService service = Provider.of<ConnectivityService>(context);
    double height = size.height * 0.63;
    double width = size.height * 0.9;
    EdgeInsets padding =
        const EdgeInsets.only(top: 50, right: 25, left: 25, bottom: 25);

    if (service.actualState == ConnectivityStatus.on) {
      if (_newFuture == null) {
        _newFuture = Provider.of<Future<Word>>(context);
        _oldFuture = _newFuture;
      }
      return getContainer(
        height: height,
        width: width,
        padding: padding,
        child: FutureBuilder<Word>(
          future: _newFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError ||
                snapshot.connectionState == ConnectionState.waiting) {
              return loadingState();
            } else {
              return getTileLayout(snapshot.data);
            }
          },
        ),
      );
    } else {
      if (_oldFuture == null)
        return loadingState();
      else
        return getContainer(
            child: FutureBuilder<Word>(
              future: _oldFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return loadingState();
                } else {
                  return getTileLayout(snapshot.data);
                }
              },
            ),
            padding: padding,
            height: height,
            width: width);
    }
  }
}

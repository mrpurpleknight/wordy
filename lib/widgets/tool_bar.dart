import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:wordy/services/failure_exception.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/providers/words.dart';
import 'package:provider/provider.dart';

class ToolBar extends StatefulWidget {
  @override
  _ToolBarState createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  Words _words;
  Color _favoriteColor;
  FailureException _lastFailure;

  @override
  void initState() {
    super.initState();
    _words = Provider.of<Words>(context, listen: false);
  }

  void setColor(Word word) {
    if (_words.isPresent(word))
      _favoriteColor = Colors.redAccent;
    else
      _favoriteColor = Colors.white38;
  }

  Future<bool> setFavorite(Word word) async {
    if (_words.isPresent(word)) {
      _words.removeWord(word);
      setState(() {
        _favoriteColor = Colors.white38;
      });
      return false;
    } else {
      _words.addWord(word);
      setState(() {
        _favoriteColor = Colors.redAccent;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<Word> wordFuture = Provider.of<Future<Word>>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.6, top: 10),
      child: FutureBuilder<Word>(
          future: wordFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError ||
                _lastFailure != null) {
              return LikeButton(
                isLiked: false,
                onTap: (bool) => Future.sync(() => bool),
                size: 55,
                likeBuilder: (_) {
                  return Icon(
                    Icons.favorite,
                    color: Colors.white38,
                    size: 55,
                  );
                },
              );
            } else {
              _lastFailure = null;
              setColor(snapshot.data);
              return LikeButton(
                isLiked: _words.isPresent(snapshot.data),
                onTap: (_) {
                  return setFavorite(snapshot.data);
                },
                size: 55,
                bubblesSize: 50,
                circleColor: CircleColor(
                  start: const Color(0xFFF64F59),
                  end: const Color(0xFFEF473A),
                ),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Colors.redAccent,
                  dotSecondaryColor: Colors.red,
                ),
                likeBuilder: (_) {
                  return Icon(
                    Icons.favorite,
                    color: _favoriteColor,
                    size: 55,
                  );
                },
              );
            }
          }),
    );
  }
}

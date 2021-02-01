import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/providers/words.dart';

abstract class AbstractToolbar extends StatefulWidget {
  AbstractToolbar({Key key}) : super(key: key);
}

abstract class AbstractToolbarState<T extends AbstractToolbar>
    extends State<T> {
  Words _words;
  Color _favoriteColor;

  Words get words => _words;

  Color get favoriteColor => _favoriteColor;

  @override
  void initState() {
    super.initState();
    _words = Words.instance;
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

  Widget getButton(Word word) {
    return LikeButton(
      isLiked: _words.isPresent(word),
      onTap: (_) {
        return setFavorite(word);
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
}

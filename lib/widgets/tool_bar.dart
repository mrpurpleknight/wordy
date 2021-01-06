import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/providers/words.dart';
import 'package:provider/provider.dart';

class ToolBar extends StatefulWidget {
  @override
  _ToolBarState createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  Words _words;
  Future<Word> _wordFuture;
  Color _favoriteColor;

  @override
  void initState() {
    super.initState();
    _words = Provider.of<Words>(context, listen: false);
    _wordFuture = Provider.of<Future<Word>>(context, listen: false);
  }

  void setColor(Word word) {
    if (_words.isPresent(word))
      _favoriteColor = Colors.redAccent;
    else
      _favoriteColor = Colors.white38;
  }

  void setFavorite(Word word) {
    if (_words.isPresent(word)) {
      _words.removeWord(word);
      setState(() {
        _favoriteColor = Colors.white38;
      });
    } else {
      _words.addWord(word);
      setState(() {
        _favoriteColor = Colors.redAccent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.6, top: 10),
      child: FutureBuilder<Word>(
          future: _wordFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('error');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return InkWell(
                onTap: () {},
                child: Icon(
                  Icons.favorite,
                  size: 55,
                  color: Colors.white38,
                ),
              );
            } else {
              setColor(snapshot.data);
              return InkWell(
                onTap: () {
                  setFavorite(snapshot.data);
                },
                child: Icon(
                  Icons.favorite,
                  size: 55,
                  color: _favoriteColor,
                ),
              );
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/providers/words.dart';
import 'package:provider/provider.dart';

class ToolBar extends StatefulWidget {

  final Word _word;
  ToolBar(this._word);

  @override
  _ToolBarState createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  Words words;
  Color favoriteColor = Colors.white38;

  @override
  void initState() {
    super.initState();
    words = Provider.of<Words>(context, listen: false);
    if(words.isPresent(widget._word)) favoriteColor = Colors.redAccent;
  }

  void setFavorite(Word word) {
    if(words.isPresent(word)) {
      words.removeWord(word);
      setState(() {
        favoriteColor = Colors.white38;
      });
    }
    else {
      words.addWord(word);
      setState(() {
        favoriteColor = Colors.redAccent;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<Word> wordFuture = Provider.of<Future<Word>>(context);

    return Container(
      margin: EdgeInsets.only(left: size.width * 0.6, top: 10),
      child: FutureBuilder<Word>(
          future: wordFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Icon(
                Icons.favorite,
                size: 55,
                color: favoriteColor,
              );
            else
              return InkWell(
                onTap: () => setFavorite(snapshot.data),
                child: Icon(
                  Icons.favorite,
                  size: 55,
                  color: favoriteColor,
                ),
              );
          }),
    );
  }
}

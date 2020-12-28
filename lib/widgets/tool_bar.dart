import 'package:flutter/material.dart';
import 'package:learn_words/providers/word.dart';
import 'package:learn_words/providers/words.dart';
import 'package:provider/provider.dart';

class ToolBar extends StatefulWidget {
  @override
  _ToolBarState createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  Words words;
  Color favoriteColor = Colors.white38;

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
    words = Provider.of<Words>(context);

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

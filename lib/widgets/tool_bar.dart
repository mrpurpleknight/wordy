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
  Color favoriteColor;

  @override
  void initState() {
    super.initState();
    words = Provider.of<Words>(context, listen: false);
    if (words.isPresent(widget._word))
      favoriteColor = Colors.redAccent;
    else
      favoriteColor = Colors.white38;
  }

  void setFavorite(Word word) {
    if (words.isPresent(word)) {
      words.removeWord(word);
      setState(() {
        favoriteColor = Colors.white38;
      });
    } else {
      words.addWord(word);
      setState(() {
        favoriteColor = Colors.redAccent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.6, top: 10),
      child: InkWell(
        onTap: () {
          if (widget._word != null)
            setFavorite(widget._word);
        },
        child: Icon(
          Icons.favorite,
          size: 55,
          color: favoriteColor,
        ),
      ),
    );
  }
}

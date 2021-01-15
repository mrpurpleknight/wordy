import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:wordy/providers/word.dart';
import 'package:provider/provider.dart';
import 'package:wordy/widgets/abstract/abstract_toolbar.dart';

class RandomToolbar extends AbstractToolbar {
  @override
  _RandomToolBarState createState() => _RandomToolBarState();
}

class _RandomToolBarState extends AbstractToolbarState<RandomToolbar> {
  Widget getFakeButton() {
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
                snapshot.hasError) {
              return getFakeButton();
            } else {
              setColor(snapshot.data);
              return getButton(snapshot.data);
            }
          }),
    );
  }
}

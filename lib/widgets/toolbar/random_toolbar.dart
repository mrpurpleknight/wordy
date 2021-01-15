import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:wordy/providers/connectivity_service.dart';
import 'package:wordy/providers/word.dart';
import 'package:provider/provider.dart';
import 'package:wordy/widgets/abstract/abstract_toolbar.dart';

class RandomToolbar extends AbstractToolbar {
  @override
  _RandomToolBarState createState() => _RandomToolBarState();
}

class _RandomToolBarState extends AbstractToolbarState<RandomToolbar> {
  Future<Word> _newFuture;
  Future<Word> _oldFuture;

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
    ConnectivityService service = Provider.of<ConnectivityService>(context);
    if (service.actualState == ConnectivityStatus.on) {
        _newFuture ??= Provider.of<Future<Word>>(context);
        _oldFuture ??= _newFuture;
      return Container(
        margin: EdgeInsets.only(left: size.width * 0.6, top: 10),
        child: FutureBuilder<Word>(
            future: _newFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.hasError)
                return getFakeButton();
              else {
                setColor(snapshot.data);
                return getButton(snapshot.data);
              }
            }),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: size.width * 0.6, top: 10),
        child: (_oldFuture == null)
            ? getFakeButton()
            : FutureBuilder<Word>(
                future: _oldFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.hasError)
                    return getFakeButton();
                  else {
                    setColor(snapshot.data);
                    return getButton(snapshot.data);
                  }
                }),
      );
    }
  }
}

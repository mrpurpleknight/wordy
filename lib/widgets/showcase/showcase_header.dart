import 'package:flutter/material.dart';
import 'package:wordy/screens/words_list_screen.dart';

class ShowcaseHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Your words',
          style: const TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w900),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 35),
          child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(WordsListScreen.routeName);
              },
              color: Colors.black26,
              height: 32,
              minWidth: 32,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Text('More',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w900))),
        )
      ],
    );
  }
}

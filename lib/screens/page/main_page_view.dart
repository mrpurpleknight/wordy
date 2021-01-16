import 'package:flutter/material.dart';
import 'package:wordy/screens/main_screen.dart';
import 'package:wordy/screens/page/random_word_page_view.dart';

class MainPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: [
        MainScreen(),
        RandomWordPageView(),
      ],
    );
  }
}

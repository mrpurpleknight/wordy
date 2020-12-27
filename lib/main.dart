import 'package:flutter/material.dart';
import 'package:learn_words/constants.dart';
import 'package:learn_words/providers/http_words.dart';
import 'package:learn_words/screens/main_screen.dart';
import 'package:learn_words/screens/word_page_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.deepPurpleAccent,
        backgroundColor: backgroundColor,
        textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
                fontFamily: 'Merriweather',
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.black),
            bodyText1: TextStyle(
                fontFamily: 'Merriweather',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black),
            bodyText2: TextStyle(
                fontFamily: 'Merriweather',
                fontSize: 14,
                fontStyle: FontStyle.italic),
            headline2: TextStyle(
                fontFamily: 'Merriweather',
                fontWeight: FontWeight.w800,
                fontSize: 26,
                color: Colors.black),
          headline3: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black),
          headline4: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 17,
              fontStyle: FontStyle.italic),
        ),
      ),
      home: WordPageView(),
    );
  }
}

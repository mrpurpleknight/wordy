import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:learn_words/providers/words.dart';
import 'package:learn_words/screens/words_list_screen.dart';
import 'package:learn_words/widgets/search_input_field.dart';
import 'package:learn_words/widgets/words_showcase.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    final Words words = Provider.of<Words>(context);
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 21, left: 32, bottom: 50),
                  child: Text(
                    'Wordy',
                    style: TextStyle(
                        fontSize: 44,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.04, left: 30, right: 30),
                      child: Text(
                        'Start your research',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SearchInputField(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: size.height * 0.125,
                        bottom: 8,
                        left: 32,
                      ),
                      child: (!words.isEmpty())
                          ? Row(
                        children: [
                          Text(
                            'Your words',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 35),
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(WordsListScreen.routeName);
                                },
                                color: Colors.black26,
                                height: 32,
                                minWidth: 32,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                child: Text('More',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900))),
                          )
                        ],
                      )
                          : Center(),
                    ),
                    WordsShowcase(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

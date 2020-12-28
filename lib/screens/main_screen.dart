import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:learn_words/constants.dart';
import 'package:learn_words/providers/words.dart';
import 'package:learn_words/widgets/search_input_field.dart';
import 'package:learn_words/widgets/word_tile_small.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Words words = Provider.of<Words>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 32, bottom: 50),
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
                          left: 32,
                          bottom: size.height * 0.01),
                      child: Text(
                        'Your words',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...words
                              .getLast5Word()
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SmallWordTile(e),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
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

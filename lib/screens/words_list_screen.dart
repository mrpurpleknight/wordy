import 'package:flutter/material.dart';
import 'package:learn_words/providers/words.dart';
import 'package:learn_words/widgets/words_grid.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class WordsListScreen extends StatelessWidget {
  static const String routeName = '/words-list';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Words.instance,
          ),
        ],
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  elevation: 10,
                  pinned: true,
                  expandedHeight: 150.0,
                  backgroundColor: Theme.of(context).accentColor,
                  snap: false,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    title: Row(
                      children: [
                        Text(
                          'My words',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(Icons.filter_list_rounded, color: Colors.white, size: 25,),
                        )
                      ],
                    ),
                  )),
              WordsGrid(),
            ],
          ),
        ),);
  }
}

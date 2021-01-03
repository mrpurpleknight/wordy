import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/words_grid.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class WordsListScreen extends StatelessWidget {
  static const String routeName = '/words-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Words.instance,
          ),
        ],
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  elevation: 4,
                  forceElevated: true,
                  shadowColor: Colors.black87,
                  actions: [Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.filter_list_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  )],
                  pinned: true,
                  expandedHeight: 150.0,
                  backgroundColor: Theme.of(context).accentColor,
                  snap: false,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Words',
                          style: TextStyle(
                              fontFamily: 'Merriweather',
                              fontWeight: FontWeight.w800,
                              fontSize: 26,
                              color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 3),
                          child: SvgPicture.asset(
                            'assets/images/vocabulary.svg',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  )),
              SliverPadding(padding: EdgeInsets.all(4), sliver: WordsGrid()),
            ],
          ),
        ),
      ),
    );
  }
}

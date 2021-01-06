import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/words_grid.dart';
import 'package:provider/provider.dart';

class WordsListScreen extends StatelessWidget {
  static const String routeName = '/words-list';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Words.instance,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 5, bottom: 22),
          child: Transform.scale(
            scale: 1.2,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).accentColor,
            ),
          ),
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  elevation: 8,
                  forceElevated: true,
                  shadowColor: Colors.black87,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.filter_list_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  ],
                  pinned: true,
                  centerTitle: true,
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
                        padding: const EdgeInsets.only(left: 12, bottom: 2),
                        child: SvgPicture.asset(
                          'assets/images/vocabulary.svg',
                          color: Colors.white,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Theme.of(context).accentColor,
                  snap: false,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                  )),
              SliverPadding(padding: EdgeInsets.only(top: 6, left: 4, right: 4, bottom: 6), sliver: WordsGrid()),
            ],
          ),
        ),
      ),
    );
  }
}

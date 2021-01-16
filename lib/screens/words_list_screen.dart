import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/overlays/overlay_menu_wrapper.dart';
import 'package:wordy/widgets/words/words_list.dart';
import 'package:provider/provider.dart';

class WordsListScreen extends StatelessWidget {
  static const String routeName = '/words-list';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Words.instance,
      child: Scaffold(
        // floatingActionButton: Padding(
        //   padding: EdgeInsets.only(right: 5, bottom: 22),
        //   child: Transform.scale(
        //     scale: 1.2,
        //     child: FloatingActionButton(
        //       onPressed: () {},
        //       child: Icon(Icons.add),
        //       backgroundColor: Theme.of(context).accentColor,
        //     ),
        //   ),
        // ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                  toolbarHeight: 66,
                  actions: [
                    OverlayMenuWrapper(
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 3),
                        child: Icon(
                          Icons.sort_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                  pinned: false,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Words',
                          style: const TextStyle(
                              fontFamily: 'Merriweather',
                              fontWeight: FontWeight.w800,
                              fontSize: 32,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 5),
                        child: SvgPicture.asset(
                          'assets/images/vocabulary.svg',
                          color: Colors.white,
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Theme.of(context).backgroundColor,
                  snap: false,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                  )),
              SliverPadding(
                  padding: const EdgeInsets.only(
                      top: 3, right: 9, bottom: 9, left: 9),
                  sliver: WordsList()),
            ],
          ),
        ),
      ),
    );
  }
}

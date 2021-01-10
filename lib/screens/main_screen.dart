import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wordy/providers/search_bar_status.dart';
import 'package:wordy/widgets/overlays/overlay_hint.dart';
import 'package:wordy/widgets/overlays/overlay_hint_wrapper.dart';
import 'package:wordy/widgets/search/search_bar.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/showcase/showcase_header.dart';
import 'package:wordy/widgets/showcase/words_showcase.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final GlobalKey _one = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Words words = Provider.of<Words>(context);
    return OverlayHintWrapper(
      keyList: [_one],
      child: FocusWatcher(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 21, left: 32, bottom: 50),
                      child: Text(
                        'Wordy',
                        style: TextStyle(
                            fontSize: 44,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Merriweather'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: size.height * 0.035, left: 30, right: 30),
                          child: Text(
                            'Start your research',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        ChangeNotifierProvider(
                            create: (_) => SearchBarStatus(
                                TextEditingController(), FocusNode()),
                            child: SearchBar()),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OverlayHint(
                          key: _one,
                          // shapeBorder: CircleBorder(),
                          overlayTile: Container(
                            width: 200,
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                    'assets/images/swipe-up.svg',
                                    color: Colors.white,
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  'Swipe up',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                              top: size.height * 0.125,
                              left: 32,
                            ),
                            child: ShowcaseHeader()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: WordsShowcase(words.getLast5Word()),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

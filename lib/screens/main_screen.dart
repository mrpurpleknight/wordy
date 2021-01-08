import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordy/widgets/search/search_bar.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:wordy/providers/words.dart';
import 'package:wordy/widgets/showcase/showcase_header.dart';
import 'package:wordy/widgets/showcase/words_showcase.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey _one = GlobalKey();
  BuildContext myContext;

  @override
  void initState() {
    super.initState();

    displayShowcase().then((bool value) {
      if (value)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(Duration(milliseconds: 300),
              () => ShowCaseWidget.of(myContext).startShowCase([_one]));
        });
    });
  }

  Future<bool> displayShowcase() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool showcaseVisibilityStatus = sharedPreferences.getBool("showcase");
    if (showcaseVisibilityStatus == null) {
      sharedPreferences.setBool("showcase", false).then((bool success) {
        if (success)
          print("good overlay");
        else
          print("error in overlay");
      });

      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Words words = Provider.of<Words>(context);
    return ShowCaseWidget(builder: Builder(
      builder: (context) {
        myContext = context;
        return FocusWatcher(
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
                              fontWeight: FontWeight.w900, fontFamily: 'Merriweather'),
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
                          SearchBar(),
                          Showcase.withWidget(
                            contentPadding: EdgeInsets.all(8),
                            key: _one,
                            width: 200,
                            height: 200,
                            shapeBorder: CircleBorder(),
                            container: Container(
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
                            child: Center(),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
        );
      },
    ));
  }
}

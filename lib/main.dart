import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:wordy/constants.dart';
import 'package:wordy/providers/connectivity_service.dart';
import 'package:wordy/screens/main_page_view.dart';
import 'package:wordy/screens/word_detail_screen.dart';
import 'package:wordy/screens/words_list_screen.dart';
import 'package:wordy/providers/word_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> appFromFuture() async {
    await Future.delayed(Duration(milliseconds: 2000));
    return Wordy();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
          navigateAfterFuture: appFromFuture(),
          title: new Text(
            'Wordy',
            style: new TextStyle(
                fontFamily: 'Merriweather',
                fontWeight: FontWeight.bold,
                fontSize: 48.0,
                color: Colors.white),
          ),
          image: Image(image: AssetImage('assets/images/dictionary.png')),
          backgroundColor: backgroundColor,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: () {},
          loaderColor: Colors.transparent),
    );
  }
}

class Wordy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Portal(
      child: MaterialApp(
        title: 'Wordy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: backgroundColor,
          accentColor: accentColor,
          backgroundColor: backgroundColor,
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                    fontFamily: 'Merriweather',
                    fontWeight: FontWeight.w800,
                    fontSize: 19,
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
                headline5: TextStyle(
                    fontFamily: 'Merriweather',
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: Colors.black),
                headline6: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
        ),
        home: ChangeNotifierProvider<ConnectivityService>(
            create: (context) =>
                ConnectivityService(),
            child: MainPageView()),
        routes: {
          WordsListScreen.routeName: (ctx) => WordsListScreen(),
          WordDetailScreen.routeName: (ctx) => WordDetailScreen(),
        },
      ),
    );
  }
}

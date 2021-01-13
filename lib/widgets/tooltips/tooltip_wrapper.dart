import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase_widget.dart';

/// This class is a wrapper for any screen which wants to display some overlay.
/// The child is the screen attached to this wrapper and should include one or more overlays with the relative keyList set.
class TooltipWrapper extends StatelessWidget {
  final Widget _child;
  final List<GlobalKey> _keyList;
  BuildContext _showcaseContext;

  TooltipWrapper({
    @required Widget child,
    @required List<GlobalKey> keyList,
  })  : _child = child,
        _keyList = keyList;

  void displayShowcase() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool showcaseVisibilityStatus = sharedPreferences.getBool("overlay");
    if (showcaseVisibilityStatus == null) {
      sharedPreferences.setBool("overlay", false).then((bool success) {});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(_showcaseContext).startShowCase(_keyList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(builder: Builder(
      builder: (context) {
        _showcaseContext = context;
        displayShowcase();
        return _child;
      },
    ));
  }

}

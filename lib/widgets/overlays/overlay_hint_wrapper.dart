import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase_widget.dart';

/// This class is a wrapper for any screen which wants to display some overlay.
/// The child is the screen attached to this wrapper and should include one or more overlays with the relative keyList set.
class OverlayHintWrapper extends StatefulWidget {
  final Widget _child;
  final List<GlobalKey> _keyList;

  const OverlayHintWrapper({
    @required Widget child,
    @required List<GlobalKey> keyList,
  })  : _child = child,
        _keyList = keyList;

  @override
  _OverlayHintWrapperState createState() => _OverlayHintWrapperState();
}

class _OverlayHintWrapperState extends State<OverlayHintWrapper> {
  BuildContext _showcaseContext;

  @override
  void initState() {
    super.initState();
    displayShowcase().then((bool value) {
      if (value)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(
              Duration(milliseconds: 300),
              () => ShowCaseWidget.of(_showcaseContext)
                  .startShowCase(widget._keyList));
        });
    });
  }

  Future<bool> displayShowcase() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool showcaseVisibilityStatus = sharedPreferences.getBool("overlay");
    if (showcaseVisibilityStatus == null) {
      sharedPreferences.setBool("overlay", false).then((bool success) {});
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(builder: Builder(
      builder: (context) {
        _showcaseContext = context;
        return widget._child;
      },
    ));
  }
}

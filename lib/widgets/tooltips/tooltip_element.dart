import 'package:flutter/material.dart';
import 'package:showcaseview/showcase.dart';

// ignore: must_be_immutable
class TooltipElement extends StatelessWidget {
  final GlobalKey _key;
  final Widget _overlayTile;
  Widget _target;
  double _width;
  double _height;

  TooltipElement({
    @required GlobalKey key,
    @required Widget overlayTile,
    Widget target,
    double width = 200,
    double height = 200,
  })  : _key = key,
        _overlayTile = overlayTile,
        _width = width,
        _height = height {
    _target = target ?? Container();
  }

  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(
      disposeOnTap: true,
      contentPadding: const EdgeInsets.all(8),
      key: _key,
      width: _width,
      height: _height,
      // shapeBorder: CircleBorder(),
      container: _overlayTile,
      child: _target,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'abstract_tile.dart';

abstract class AbstractWordTile extends AbstractTile {
  AbstractWordTile({Key key}) : super(key: key);
}

abstract class AbstractWordTileState<T extends AbstractTile>
    extends AbstractTileState<T> {
  Widget getContainer(
      {@required Widget child,
      @required EdgeInsets padding,
      @required double height,
      @required double width}) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration: super.getContainerDecoration(1.7, Offset(2, 4)),
      child: child,
    );
  }
}

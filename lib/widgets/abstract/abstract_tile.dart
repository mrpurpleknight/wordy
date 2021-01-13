import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AbstractTile extends StatefulWidget {
  AbstractTile({Key key}) : super(key: key);
}

abstract class AbstractTileState<T extends StatefulWidget> extends State<T> {
  BoxDecoration getContainerDecoration(double borderWidth, Offset shadowOffset) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(color: Colors.black.withOpacity(0.63), width: borderWidth),
      boxShadow: [
        BoxShadow(
          color: Colors.black12.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 2,
          offset: shadowOffset , // changes position of shadow
        ),
      ],
    );
  }
}

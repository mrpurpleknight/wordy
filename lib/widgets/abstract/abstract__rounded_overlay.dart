import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

abstract class AbstractRoundedOverlay extends StatefulWidget {
  final Widget _target;

  AbstractRoundedOverlay({Key key, @required Widget target})
      : _target = target,
        super(key: key);
}

abstract class AbstractRoundedOverlayState<T extends AbstractRoundedOverlay>
    extends State<T> {
  LayerLink _layerLink;

  @override
  void initState() {
    super.initState();
    _layerLink = LayerLink();
  }

  Widget getPortal(Widget follower, bool isVisible) {
    return PortalEntry(
      visible: isVisible,
      portalAnchor: Alignment.topCenter,
      childAnchor: Alignment.bottomCenter,
      portal: getFollower(follower),
      child: getTarget(),
    );
  }

  Widget getFollower(Widget child) {
    return CompositedTransformFollower(
      link: _layerLink,
      showWhenUnlinked: false,
      offset: Offset(-15, 60.0 - 10),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4.0,
        child: child,
      ),
    );
  }

  Widget getTarget() {
    return CompositedTransformTarget(link: _layerLink, child: widget._target);
  }
}

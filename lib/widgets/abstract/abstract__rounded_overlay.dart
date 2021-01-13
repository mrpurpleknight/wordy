import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:wordy/widgets/overlays/overlay_position.dart';

abstract class AbstractRoundedOverlay extends StatefulWidget {
  final Widget _target;
  final OverlayPosition _position;

  AbstractRoundedOverlay(
      {Key key, @required Widget target, @required OverlayPosition position})
      : _target = target,
        _position = position,
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
      portalAnchor: widget._position.portalAnchor,
      childAnchor: widget._position.childAnchor,
      portal: getFollower(follower),
      child: getTarget(),
    );
  }

  Widget getFollower(Widget child) {
    return CompositedTransformFollower(
      link: _layerLink,
      showWhenUnlinked: false,
      offset: widget._position.offset,
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

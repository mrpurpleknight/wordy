import 'package:flutter/material.dart';

class OverlayPosition {
  final Alignment _portalAnchor;
  final Alignment _childAnchor;
  final Offset _offset;

  const OverlayPosition({
    @required Alignment portalAnchor,
    @required Alignment childAnchor,
    @required Offset offset,
  })  : _portalAnchor = portalAnchor,
        _childAnchor = childAnchor,
        _offset = offset;

  Offset get offset => _offset;

  Alignment get childAnchor => _childAnchor;

  Alignment get portalAnchor => _portalAnchor;
}
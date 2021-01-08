import 'package:flutter/cupertino.dart';

class InputStatus {
  final TextEditingController _controller;
  final FocusNode _focusNode;

  InputStatus(this._controller, this._focusNode);

  TextEditingController get controller => _controller;
  FocusNode get focusNode => _focusNode;

  void refreshInput() {
    _focusNode.unfocus();
    _controller.text = '';
  }

}
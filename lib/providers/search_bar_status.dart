import 'package:flutter/material.dart';
import 'package:throttling/throttling.dart';

class SearchBarStatus extends ChangeNotifier {

  final TextEditingController _controller;
  final FocusNode _focusNode;
  bool _isVisible;
  String _textToSearch;
  final Debouncing _deb;

  SearchBarStatus(this._controller, this._focusNode, {int milliseconds = 250})
      : _isVisible = false,
        _deb = Debouncing(duration: Duration(milliseconds: milliseconds)) {
    _focusNode.addListener(_focusNodeListener);
    _controller.addListener(_textControllerListener);
    _controller.addListener(_debounceTextToSearch);
  }

  TextEditingController get controller => _controller;
  FocusNode get focusNode => _focusNode;
  bool get isVisible => _isVisible;
  String get textToSearch => _textToSearch;

  setOpen(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  void _debounceTextToSearch() {
    _deb.debounce(() {
      _textToSearch = _controller.text;
      notifyListeners();
    });
  }

  void _textControllerListener() {
    if (_controller.text != '' && _focusNode.hasFocus)
      setOpen(true);
    if (_controller.text == '')
      setOpen(false);
  }

  void _focusNodeListener() {
    if (!_focusNode.hasFocus) setOpen(false);
  }

  void refreshInput() {
    _focusNode.unfocus();
    _controller.text = '';
  }
}

import 'package:flutter/material.dart';
import 'package:throttling/throttling.dart';

class SearchBarStatus extends ChangeNotifier {

  final TextEditingController _controller;
  final FocusNode _focusNode;
  bool _isVisible;
  String _textToSearch;
  final Debouncing deb = Debouncing(duration: Duration(milliseconds: 250));

  SearchBarStatus(this._controller, this._focusNode) : _isVisible = false {
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
    deb.debounce(() {
      _textToSearch = _controller.text;
      notifyListeners();
    });
  }

  void _textControllerListener() {
    if (_controller.text != '') {
      setOpen(true);
    }
    if (_controller.text == '') {
      setOpen(false);
    }
  }

  void _focusNodeListener() {
    if (!_focusNode.hasFocus) setOpen(false);
  }

  void refreshInput() {
    _focusNode.unfocus();
    _controller.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    focusNode.dispose();
  }
}

import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController _controller;
  final Function _onSubmitCallback;
  final FocusNode _focusNode;

  SearchInputField({
    @required TextEditingController controller,
    @required Function onSubmitCallback,
    @required FocusNode focusNode,
  })  : _controller = controller,
        _onSubmitCallback = onSubmitCallback,
        _focusNode = focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.words,
      controller: _controller,
      onSubmitted: (String text) => _onSubmitCallback(text),
      focusNode: _focusNode,
      style: TextStyle(
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: Colors.black),
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

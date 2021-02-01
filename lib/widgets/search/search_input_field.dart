import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordy/providers/search_bar_status.dart';

class SearchInputField extends StatelessWidget {
  final Function _onSubmitCallback;

  SearchInputField(this._onSubmitCallback);

  @override
  Widget build(BuildContext context) {
    SearchBarStatus inputStatus = Provider.of<SearchBarStatus>(context);
    return TextField(
      textCapitalization: TextCapitalization.words,
      controller: inputStatus.controller,
      onSubmitted: (String text) {
        inputStatus.refreshInput();
        _onSubmitCallback(text);},
      focusNode: inputStatus.focusNode,
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

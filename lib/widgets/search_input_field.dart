import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 15),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: "Search a word",
                hintStyle: TextStyle(
                    color: Theme.of(context).backgroundColor.withOpacity(0.6),
                    fontSize: 18),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Icon(
            Icons.search,
            size: 35,
            color: Theme.of(context).backgroundColor,
          ),
        ],
      ),
    );
  }
}

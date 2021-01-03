import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:wordy/providers/word.dart';

import 'suggestions_list.dart';

class SearchInputField extends StatefulWidget {
  @override
  _SearchInputFieldState createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  final _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  TextEditingController _myController = TextEditingController();
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          isOpen = false;
        });
      }
    });

    _myController.addListener(() {
      if (_myController.text != '' && _focusNode.hasFocus) {
        setState(() {
          isOpen = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 15),
      height: 60,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CompositedTransformTarget(
              link: _layerLink,
              child: PortalEntry(
                visible: isOpen,
                portalAnchor: Alignment.topCenter,
                childAnchor: Alignment.bottomLeft,
                portal: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(-15, 60.0 - 17.0),
                  child: Material(
                    elevation: 4.0,
                    child: FutureBuilder<List<Word>>(
                      future: Word.suggestions(_myController.text, 5),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            width: size.width * 0.75,
                            child: SuggestionsList(snapshot.data,
                                controller: _myController),
                          );
                        } else
                          return Container(
                            width: size.width * 0.75,
                            child: ListTile(
                              title: Text(
                                '...',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              trailing: Icon(
                                Icons.search,
                                size: 30,
                              ),
                            ),
                          );
                      },
                    ),
                  ),
                ),
                child: TextField(
                  controller: _myController,
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

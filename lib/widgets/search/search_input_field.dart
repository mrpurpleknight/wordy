import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/word_detail_screen.dart';

import 'suggestions_list.dart';

class SearchInputField extends StatefulWidget {
  @override
  _SearchInputFieldState createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  final _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  TextEditingController _controller = TextEditingController();
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

    _controller.addListener(() {
      if (_controller.text != '' && _focusNode.hasFocus) {
        setState(() {
          isOpen = true;
        });
      }
    });
  }

  void refreshInput(TextEditingController controller) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (currentFocus.focusedChild != null) {
      currentFocus.focusedChild.unfocus();
    }

    controller.text = '';
  }

  void goToDetail(String name) {
    Word.byName(name).then((value) {
      if(value != null) {
        refreshInput(_controller);
        Navigator.of(context)
            .pushNamed(WordDetailScreen.routeName, arguments: value);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                  offset: Offset(-15, 60.0 - 10),
                  child: Material(
                    elevation: 4.0,
                    child: FutureBuilder<List<Word>>(
                      future: Word.suggestions(_controller.text, 5),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            width: size.width * 0.75,
                            constraints: BoxConstraints(
                              maxHeight: size.height * 0.29,
                            ),
                            child: SuggestionsList(snapshot.data,
                                refreshInputCallback: refreshInput,
                                controller: _controller),
                          );
                        } else
                          return Container(
                            width: size.width * 0.75,
                            child: ListTile(
                              title: Text(
                                '...',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline5,
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.search,
                                  color: Theme
                                      .of(context)
                                      .backgroundColor,
                                  size: 30,
                                ),
                              ),
                            ),
                          );
                      },
                    ),
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (String text) => goToDetail(text),
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
          InkWell(
            onTap: () => goToDetail(_controller.text),
            child: Icon(
              Icons.search,
              size: 35,
              color: Theme
                  .of(context)
                  .backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

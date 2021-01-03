import 'package:flutter/material.dart';
import 'package:learn_words/providers/word.dart';
import 'package:throttling/throttling.dart';

class SearchInputField extends StatefulWidget {
  @override
  _SearchInputFieldState createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  final _focusNode = FocusNode();
  OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  TextEditingController _myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _overlayEntry.remove();
      }
    });

    _myController.addListener(() {
      if(_myController.text != '' && _focusNode.hasFocus) {
        _overlayEntry = showSuggestionsOverlay(_myController.text);
        WidgetsBinding.instance.addPostFrameCallback((_) => Overlay.of(context).insert(_overlayEntry));
      }
    });
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  OverlayEntry showSuggestionsOverlay(String text) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
        builder: (context) => Positioned(
              top: offset.dy + size.height,
              left: offset.dx + 50,
              width: size.width - size.width * 0.25,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height - 14),
                child: Material(
                  elevation: 4.0,
                  child: FutureBuilder<List<Word>>(
                    future: Word.suggestions(text, 5),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      snapshot.data.elementAt(index).name,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Text(
                                        '[${snapshot.data.elementAt(index).partOfSpeechAbbreviation}.]',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Icon(Icons.search),
                              );
                            });
                      } else
                        return Center();
                    },
                  ),
                ),
              ),
            ));
  }

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CompositedTransformTarget(
              link: _layerLink,
              child: TextField(
                controller: _myController,
                focusNode: _focusNode,
                style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Search a word",
                  hintStyle: TextStyle(
                      fontFamily: 'Merriweather',
                      color: Colors.black.withOpacity(0.63),
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

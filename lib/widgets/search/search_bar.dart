import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/word_detail_screen.dart';
import 'package:wordy/widgets/search/search_input_field.dart';
import 'package:wordy/widgets/search/suggestions_overlay.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
      if (_controller.text == '') {
        setState(() {
          isOpen = false;
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
      if (value != null) {
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
            child: SuggestionsOverlay(
              _controller,
              isOpen,
              child: CompositedTransformTarget(
                link: _layerLink,
                child: SearchInputField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onSubmitCallback: goToDetail),
              ),
              layerLink: _layerLink,
              callback: refreshInput,
            ),
          ),
          InkWell(
            onTap: () => goToDetail(_controller.text),
            child: Icon(
              Icons.search,
              size: 35,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordy/providers/search_bar_status.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/screens/word_detail_screen.dart';
import 'package:wordy/widgets/mixins/snackbar_mixin.dart';
import 'package:wordy/widgets/search/search_input_field.dart';
import 'package:wordy/widgets/search/suggestions_overlay.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with SnackBarMixin {
  final LayerLink _layerLink = LayerLink();
  SearchBarStatus _searchBarStatus;

  void goToDetail(String name) {
    Word.byName(name).then((value) {
      if (value != null) {
        Navigator.of(context)
            .pushNamed(WordDetailScreen.routeName, arguments: value);
      }
    });
  }

  @override
  void dispose() {
    _searchBarStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SearchBarStatus searchBarStatus = Provider.of<SearchBarStatus>(context);
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
              child: CompositedTransformTarget(
                link: _layerLink,
                child: SearchInputField(goToDetail),
              ),
              layerLink: _layerLink,
            ),
          ),
          InkWell(
            onTap: () => goToDetail(searchBarStatus.controller.text),
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

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wordy/constants.dart';
import 'package:wordy/services/failure_exception.dart';
import 'package:wordy/providers/search_bar_status.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/abstract/abstract__rounded_overlay.dart';
import 'package:wordy/widgets/mixins/snackbar_mixin.dart';
import 'package:wordy/widgets/search/suggestions_list.dart';

class SuggestionsOverlay extends AbstractRoundedOverlay {
  SuggestionsOverlay({
    @required Widget child,
  }) : super(target: child);

  @override
  _SuggestionsOverlayState createState() => _SuggestionsOverlayState();
}

class _SuggestionsOverlayState
    extends AbstractRoundedOverlayState<SuggestionsOverlay> with SnackBarMixin {
  FailureException _failure;

  Widget buildLoadingTile(double screenWidth) {
    return Container(
      width: screenWidth * 0.77,
      child: ListTile(
        title: SizedBox(
          width: 50,
          height: 10,
          child: Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.45),
            child: SpinKitThreeBounce(
              size: 13,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Icon(
            Icons.search,
            color: Theme.of(context).backgroundColor,
            size: 30,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final SearchBarStatus searchBarStatus =
        Provider.of<SearchBarStatus>(context);
    Future<List<Word>> suggestionsFuture =
        Word.suggestions(searchBarStatus.textToSearch, SUGGESTIONS_NUMBER)
            .catchError((error) {
      _failure = error;
      showSnackBar(error.toString(), context);
    });
    return getPortal(
        FutureBuilder<List<Word>>(
          initialData: [Word.empty()],
          future: suggestionsFuture,
          builder: (context, snapshot) {
            if (_failure != null ||
                snapshot.hasError ||
                snapshot.connectionState == ConnectionState.waiting) {
              return buildLoadingTile(size.width);
            } else {
              return Container(
                width: size.width * 0.77,
                constraints: BoxConstraints(
                  maxHeight: size.height * 0.29,
                ),
                child: SuggestionsList(snapshot.data),
              );
            }
          },
        ),
        searchBarStatus.isVisible);
  }
}

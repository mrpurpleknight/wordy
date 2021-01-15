import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordy/constants.dart';
import 'package:wordy/providers/connectivity_service.dart';
import 'package:wordy/providers/word_manager.dart';
import 'package:wordy/services/failure_exception.dart';
import 'package:wordy/providers/search_bar_status.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/abstract/abstract__rounded_overlay.dart';
import 'package:wordy/widgets/mixins/snackbar_mixin.dart';
import 'package:wordy/widgets/overlays/overlay_position.dart';
import 'package:wordy/widgets/search/entries/loading_entry.dart';
import 'package:wordy/widgets/search/entries/no_result_entry.dart';
import 'package:wordy/widgets/search/suggestions_list.dart';

class SuggestionsOverlay extends AbstractRoundedOverlay {
  SuggestionsOverlay(
      {@required Widget child, @required OverlayPosition overlayPosition})
      : super(target: child, position: overlayPosition);

  @override
  _SuggestionsOverlayState createState() => _SuggestionsOverlayState();
}

class _SuggestionsOverlayState
    extends AbstractRoundedOverlayState<SuggestionsOverlay> with SnackBarMixin {
  FailureException _failure;

  Widget getContent(Widget child, double width, double height) {
    return Container(
        width: width,
        constraints: BoxConstraints(
          maxHeight: height,
        ),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final SearchBarStatus searchBarStatus =
        Provider.of<SearchBarStatus>(context);
    ConnectivityService service = Provider.of<ConnectivityService>(context);

    if (service.actualState == ConnectivityStatus.on) {
      _failure = null;
      Future<List<Word>> suggestionsFuture = WordManager.instance
          .getSuggestionsFromName(
              searchBarStatus.textToSearch, SUGGESTIONS_NUMBER)
          .catchError((error) {
        showSnackBar(error.toString(), context);
        _failure = error;
      });
      return getPortal(
          FutureBuilder<List<Word>>(
            initialData: [Word.empty()],
            future: suggestionsFuture,
            builder: (context, snapshot) {
              if (_failure != null ||
                  snapshot.hasError ||
                  snapshot.connectionState == ConnectionState.waiting)
                return getContent(
                    LoadingEntry(), size.width * 0.77, size.height * 0.29);
              else
                return getContent(
                    (snapshot.data.length == 0)
                        ? NoResultEntry()
                        : SuggestionsList(snapshot.data),
                    size.width * 0.77,
                    size.height * 0.29);
            },
          ),
          searchBarStatus.isVisible);
    } else {
      _failure = FailureException('No Internet connection');
      return getPortal(
        getContent(LoadingEntry(), size.width * 0.77, size.height * 0.29),
        searchBarStatus.isVisible,
      );
    }
  }
}

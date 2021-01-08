import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:throttling/throttling.dart';
import 'package:wordy/business/failure_exception.dart';
import 'package:wordy/providers/input_status.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/mixins/snackbar_mixin.dart';
import 'package:wordy/widgets/search/suggestions_list.dart';

class SuggestionsOverlay extends StatefulWidget {
  final Widget _child;
  final bool _isVisible;
  final LayerLink _layerLink;

  SuggestionsOverlay(
      {@required bool isVisible,
      @required Widget child,
      @required LayerLink layerLink})
      : _child = child,
        _isVisible = isVisible,
        _layerLink = layerLink;

  @override
  _SuggestionsOverlayState createState() => _SuggestionsOverlayState();
}

class _SuggestionsOverlayState extends State<SuggestionsOverlay>
    with SnackBarMixin {
  Future<List<Word>> _suggestionsFuture;
  String _textToSearch = '';
  FailureException _failure;

  @override
  void initState() {
    super.initState();
    final Debouncing deb = Debouncing(duration: Duration(milliseconds: 250));

    final InputStatus inputStatus =
        Provider.of<InputStatus>(context, listen: false);
    inputStatus.controller.addListener(() {
      deb.debounce(() {
        if (inputStatus.controller.text != null) {
          setState(() {
            _textToSearch = inputStatus.controller.text;
            _suggestionsFuture =
                Word.suggestions(_textToSearch, 6).catchError((error) {
              _failure = error;
              showSnackBar(error.toString(), context);
            });
          });
        }
      });
    });
  }

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
    return PortalEntry(
      visible: widget._isVisible,
      portalAnchor: Alignment.topCenter,
      childAnchor: Alignment.bottomLeft,
      portal: CompositedTransformFollower(
        link: widget._layerLink,
        showWhenUnlinked: false,
        offset: Offset(-15, 60.0 - 10),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4.0,
          child: FutureBuilder<List<Word>>(
            initialData: [Word.empty()],
            future: _suggestionsFuture,
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
        ),
      ),
      child: widget._child,
    );
  }
}

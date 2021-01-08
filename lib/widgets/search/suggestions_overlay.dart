import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:throttling/throttling.dart';
import 'package:wordy/business/failure_exception.dart';
import 'package:wordy/providers/suggestions.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/widgets/search/suggestions_list.dart';
import 'package:snack/snack.dart';

// ignore: must_be_immutable
class SuggestionsOverlay extends StatefulWidget {
  final Widget _child;
  final TextEditingController _controller;
  bool _isVisible;
  final LayerLink _layerLink;
  final Function _callback;

  SuggestionsOverlay(
    this._controller,
    this._isVisible, {
    @required Widget child,
    @required LayerLink layerLink,
    @required Function callback,
  })  : _child = child,
        _layerLink = layerLink,
        _callback = callback;

  @override
  _SuggestionsOverlayState createState() => _SuggestionsOverlayState();
}

class _SuggestionsOverlayState extends State<SuggestionsOverlay> {
  String _textToSearch;
  Future<List<Word>> suggestionsFuture;
  Object lastFailure;

  @override
  void initState() {
    super.initState();

    _textToSearch = '';
    final Debouncing deb = Debouncing(duration: Duration(milliseconds: 200));

    widget._controller.addListener(() {
      if (widget._controller.text != null) {
        setState(() {
          _textToSearch = widget._controller.text;
          suggestionsFuture =
              Word.suggestions(_textToSearch, 6).catchError((error) {
            lastFailure = error;
          });
        });
      }
    });
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
            future: suggestionsFuture,
            builder: (context, snapshot) {
              if (lastFailure != null) {
                return Center(
                  child: Text(lastFailure.toString()),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: size.width * 0.77,
                  child: ListTile(
                    title: SizedBox(
                      width: 50,
                      height: 10,
                      child: Padding(
                        padding: EdgeInsets.only(right: size.width * 0.45),
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
              } else {
                return Container(
                  width: size.width * 0.77,
                  constraints: BoxConstraints(
                    maxHeight: size.height * 0.29,
                  ),
                  child: SuggestionsList(snapshot.data,
                      refreshInputCallback: widget._callback,
                      controller: widget._controller),
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

import 'package:flutter/widgets.dart';
import 'package:wordy/business/failure_exception.dart';
import 'package:wordy/business/http_words.dart';
import 'package:wordy/providers/word.dart';

class Suggestions with ChangeNotifier {
  List<Word> _suggestions;
  NotifierState _state;
  FailureException _failure;

  Suggestions() : _suggestions = [], _state = NotifierState.initial;

  List<Word> get suggestions {
    List<Word> toReturn = _suggestions;
    _suggestions = [];
    _state = NotifierState.loading;
    return toReturn;
  }
  NotifierState get state => _state;
  FailureException get failure => _failure;

  void _setSuggestions(List<Word> suggestions) {
    _suggestions = suggestions;
    notifyListeners();
  }

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void setFailure(FailureException value) {
    _failure = value;
    notifyListeners();
  }

   void getWords(String name, int limit) async {
     _setState(NotifierState.loading);
     _setSuggestions([]);
    try {
      List<Word> suggestions = await HttpWords.instance.getSuggestionsFromWordName(name, limit);
      _setSuggestions(suggestions);
    }
    on FailureException catch (f) {
      setFailure(f);
    }
    _setState(NotifierState.loaded);
  }
}

enum NotifierState { initial, loading, loaded }
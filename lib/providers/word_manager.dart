import 'package:async/async.dart';
import 'package:wordy/providers/word.dart';
import 'dart:async';

import 'package:wordy/services/failure_exception.dart';
import 'package:wordy/services/http_words.dart';

class WordManager {
  static WordManager _instance;
  StreamQueue<Word> _queue;

  WordManager._internal()
      : _queue = StreamQueue(HttpWords.instance.getRandomWords());

  static WordManager get instance {
    if (_instance == null) _instance = WordManager._internal();
    return _instance;
  }

  Future<Word> getRandomWord() async {
    try {
      Word toReturn = await _queue.next;
      return toReturn;
    } catch (e) {
      _queue = StreamQueue(HttpWords.instance.getRandomWords());
      throw FailureException('No Internet connection');
    }
  }

  Future<Word> getWordFromName(String name) async {
    return HttpWords.instance.getWordFromName(name);
  }

  Future<List<Word>> getSuggestionsFromName(String name, int limit) async {
    return HttpWords.instance.getSuggestionsFromWordName(name, limit);
  }
}

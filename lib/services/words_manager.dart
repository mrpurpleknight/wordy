import 'package:async/async.dart';
import 'package:wordy/constants.dart';
import 'package:wordy/providers/word.dart';
import 'dart:async';

class RandomWordsManager {
  static RandomWordsManager _instance;
  final StreamQueue<Word> _queue;

  RandomWordsManager._internal()
      : _queue = StreamQueue(Word.randomList(CACHE_SIZE));

  static RandomWordsManager get instance {
    if (_instance == null) _instance = RandomWordsManager._internal();
    return _instance;
  }

  Future<Word> getRandomWord() async {
    bool hasNext = await _queue.hasNext;
    while(!hasNext)
      hasNext = await _queue.hasNext;

    return _queue.next;
  }

}

import 'package:async/async.dart';
import 'package:wordy/providers/word.dart';
import 'dart:async';

import 'package:wordy/services/failure_exception.dart';

class RandomWordManager {
  static RandomWordManager _instance;
  final StreamQueue<Word> _queue;

  RandomWordManager._internal() : _queue = StreamQueue(Word.randomList());

  static RandomWordManager get instance {
    if (_instance == null) _instance = RandomWordManager._internal();
    return _instance;
  }

  Future<Word> getRandomWord() async {
    try {
      return _queue.next;
    } catch (e) {
      throw FailureException('No Internet connection');
    }
  }
}

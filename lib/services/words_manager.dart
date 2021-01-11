import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordy/constants.dart';
import 'package:wordy/providers/word.dart';

class RandomWordsManager with ChangeNotifier {
  final List<Word> _wordsCache;
  int _stackPointer;
  int _actualSize;
  static RandomWordsManager _instance;

  RandomWordsManager._internal()
      : _wordsCache = [],
        _stackPointer = 0,
        _actualSize = 0;

  static RandomWordsManager get instance {
    if (_instance == null) _instance = RandomWordsManager._internal();
    return _instance;
  }

  int get size {
    return _wordsCache.length;
  }

  Future<void> loadWords() async {
    await Word.randomList(CACHE_SIZE).then((value) {
      for(int i = 0; i < value.length; i++) {
        _wordsCache.add(value[i]);
        _actualSize++;
        notifyListeners();
      }
    });
  }

  Future<Word> get randomWord async {
    Word toReturn;
    while (toReturn == null) {
      toReturn = _wordsCache.elementAt(_stackPointer);
      if (toReturn == null || _stackPointer <= _actualSize - 2)
        await loadWords();
    }
    _stackPointer++;

    return toReturn;
  }
}

import 'package:synchronized/synchronized.dart';
import 'package:throttling/throttling.dart';
import 'package:wordy/constants.dart';
import 'package:wordy/providers/word.dart';

class RandomWordsManager {
  List<Word> _wordsCache;
  int _stackPointer;
  int _actualSize;
  static RandomWordsManager _instance;
  final Lock _lock;

  RandomWordsManager._internal()
      : _wordsCache = [],
        _stackPointer = 0,
        _actualSize = 0,
        _lock = Lock(reentrant: true);

  static RandomWordsManager get instance {
    if (_instance == null) _instance = RandomWordsManager._internal();
    return _instance;
  }

  int get size {
    return _wordsCache.length;
  }

  void cleanCache() {
    _wordsCache = _wordsCache.sublist(_actualSize -1);
    _actualSize = _wordsCache.length;
    _stackPointer = 0;
  }

  Future<void> loadWords() async {
    await _lock.synchronized(() {

      if(_actualSize >= 30)
        cleanCache();

      Debouncing deb = Debouncing(duration: Duration(seconds: 1));
      deb.debounce(() {
        Word.randomList(CACHE_SIZE).then((value) {
          for (int i = 0; i < value.length; i++) {
            _wordsCache.add(value[i]);
            _actualSize++;
          }
        });
      });
    });
  }

  Future<Word> get randomWord async {
    Word toReturn;
    while (toReturn == null) {
      toReturn = _wordsCache.elementAt(_stackPointer);
      if (toReturn == null || _stackPointer <= _actualSize - 1)
        await loadWords();
    }
    await _lock.synchronized(() => _stackPointer++);

    return toReturn;
  }
}

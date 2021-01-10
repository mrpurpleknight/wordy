import 'package:wordy/constants.dart';
import 'package:wordy/providers/word.dart';

class RandomWordsManager {
  final List<Word> _wordsCache;
  int _stackPointer;
  int _actualSize;
  static RandomWordsManager _instance;

  RandomWordsManager._internal()
      : _wordsCache = [],
        _stackPointer = 0, _actualSize = 0;
  
  static RandomWordsManager get instance {
    if (_instance == null) _instance = RandomWordsManager._internal();
    return _instance;
  }
  
  Future<void> loadWords() async {
    // await Word.randomList(CACHE_SIZE).then((value) => value.forEach((element) {
    //       _wordsCache.add(element);
    //       _actualSize += 1;
    //     }));
    randomWord.then((value) => _wordsCache.add(value));
    print(_wordsCache.length);
  }

  Future<Word> get randomWord async{
    Word toReturn = _wordsCache.elementAt(_stackPointer);
    
    if(toReturn == null)
      await Word.random().then((value) => toReturn = value);
    else 
      _stackPointer++;
    
    if(_stackPointer >= _actualSize - 4)
      loadWords();
    
    return toReturn;
  }
}

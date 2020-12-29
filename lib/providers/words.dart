import 'package:flutter/material.dart';
import 'package:learn_words/repository/words_repository.dart';

import 'word.dart';

class Words with ChangeNotifier {
  List<Word> _wordsList;
  final WordsRepository _repository;

  Words() : _repository = WordsRepository.instance {
    _repository.readAll().then((value) {
      _wordsList = value;
      notifyListeners();
    });
  }

  int get size {
    if(_wordsList == null) return 0;
    return _wordsList.length;
  }

  void addWord(Word word) {
    _wordsList.add(word);
    notifyListeners();
    _repository.write(word);
  }

  void removeWord(Word word) {
    _wordsList.removeWhere((element) => element.name == word.name);
    notifyListeners();
  }

  bool isPresent(Word word) {
    return _wordsList.contains(word);
  }

  bool isEmpty() {
    if(_wordsList != null)
      return _wordsList.isEmpty;

    return false;
  }

  Word get(int index) {
    return _wordsList.elementAt(index);
  }

  Word getByName(String name) {
    return _wordsList.firstWhere((element) => element.name == name);
  }

  List<Word> getLast5Word() {
    if (size > 5) {
      return _wordsList.sublist(size - 5);
    }
    if(_wordsList == null)
      return [];

    return _wordsList;
  }
}

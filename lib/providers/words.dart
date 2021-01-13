import 'package:flutter/material.dart';
import 'package:wordy/repository/words_repository.dart';
import 'package:wordy/services/order/list/ordered_list.dart';
import 'package:wordy/services/order/list/word_ordered_list.dart';

import 'word.dart';

class Words with ChangeNotifier {
  List<Word> _wordsList;
  WordOrderedList _orderedList;
  final WordsRepository _repository;

  static Words _instance;

  Words._internal() : _repository = WordsRepository.instance {
    _repository.readAll().then((value) {
      _wordsList = value;
      _orderedList = WordOrderedList(toOrder: _wordsList);
      notifyListeners();
    });
  }

  void sortByAlphabetical() {
    _orderedList.alphabeticalOrder();
    notifyListeners();
  }

  void sortByPartOfSpeech() {
    _orderedList.partOfSpeechOrder();
    notifyListeners();
  }

  static Words get instance {
    if (_instance == null) _instance = Words._internal();
    return _instance;
  }

  int get size {
    if (_wordsList == null) return 0;
    return _wordsList.length;
  }

  List<Word> getList() {
    return _wordsList;
  }

  List<Word> getOrderedList() {
    return _orderedList.toOrder;
  }

  void addWord(Word word) {
    if (!this.isPresent(word)) {
      _wordsList.add(word);
      notifyListeners();
      _repository.write(word);
    }
  }

  void removeWord(Word word) {
    _wordsList.removeWhere((element) => element.name == word.name);
    _repository.delete(word);
    notifyListeners();
  }

  bool isPresent(Word word) {
    return _wordsList.contains(word);
  }

  bool isEmpty() {
    if (_wordsList != null) return _wordsList.isEmpty;

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
    if (_wordsList == null) return [];

    return _wordsList;
  }
}

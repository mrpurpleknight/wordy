import 'package:flutter/material.dart';

import 'word.dart';

class Words with ChangeNotifier {
  List<Word> _wordsList;

  Words() : _wordsList = [];

  List<Word> get wordsList => _wordsList;

  void addWord(Word word) {
    _wordsList.add(word);
  }

  void removeWord(Word word) {
    _wordsList.removeWhere((element) => element.name == word.name);
  }
}

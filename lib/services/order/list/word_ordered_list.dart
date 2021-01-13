import 'package:flutter/material.dart';
import 'package:wordy/providers/word.dart';
import 'package:wordy/services/order/alphabetical_order.dart';
import 'package:wordy/services/order/list/ordered_list.dart';
import 'package:wordy/services/order/part_of_speech_order.dart';

class WordOrderedList extends OrderedList<Word> {
  final PartOfSpeechOrder _partOfSpeechOrder;
  final AlphabeticalOrder _alphabeticalOrder;

  WordOrderedList({List<Word> toOrder})
      : _partOfSpeechOrder = PartOfSpeechOrder(),
        _alphabeticalOrder = AlphabeticalOrder(),
        super(toOrder: toOrder);

  List<Word> alphabeticalOrder() {
    return _alphabeticalOrder.sort(toOrder);
  }

  List<Word> partOfSpeechOrder() {
    return _partOfSpeechOrder.sort(toOrder);
  }
}

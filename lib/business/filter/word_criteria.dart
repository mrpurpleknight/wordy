import 'package:wordy/providers/word.dart';

abstract class WordCriteria<T> {
  List<Word> filter(List<Word> list);
}
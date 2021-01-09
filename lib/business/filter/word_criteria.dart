import 'package:wordy/providers/word.dart';

abstract class WordCriteria {
  List<Word> filter(List<Word> list);
}
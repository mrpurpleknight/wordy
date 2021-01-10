import 'package:wordy/providers/word.dart';

abstract class WordOrder {
  List<Word> sort(List<Word> list);
}
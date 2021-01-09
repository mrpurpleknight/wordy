import 'package:wordy/business/order/word_order.dart';
import 'package:wordy/providers/word.dart';

class PartOfSpeechOrder extends WordOrder {
  @override
  List<Word> sort(List<Word> list) {
    list.sort((a, b) => a.partOfSpeech.compareTo(b.partOfSpeech));
    return list;
  }
}

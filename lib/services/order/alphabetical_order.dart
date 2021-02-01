import 'package:wordy/services/order/word_order.dart';
import 'package:wordy/providers/word.dart';

class AlphabeticalOrder extends WordOrder {

  @override
  List<Word> sort(List<Word> list) {
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }
}

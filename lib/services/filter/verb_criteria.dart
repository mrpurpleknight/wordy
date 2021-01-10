import 'package:wordy/services/decoder/part_of_speech.dart';
import 'package:wordy/services/filter/word_criteria.dart';
import 'package:wordy/providers/word.dart';

class VerbCriteria extends WordCriteria{

  @override
  List<Word> filter(List<Word> list) {
    return list.where((element) => element.partOfSpeechEnum == PartOfSpeech.verb);
  }
}
import 'package:enum_to_string/enum_to_string.dart';
import 'package:wordy/business/decoder/part_of_speech.dart';

class EnumStringConverter {
  static PartOfSpeech stringToEnum(String toConvert) {
    return EnumToString.fromString(PartOfSpeech.values, toConvert);
  }

  static String enumToString(PartOfSpeech toConvert) {
    return EnumToString.convertToString(toConvert);
  }
}

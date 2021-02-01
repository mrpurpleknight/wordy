import 'dart:convert';

import 'package:wordy/services/decoder/enum_string_converter.dart';
import 'package:wordy/services/decoder/json_decoder_strategy.dart';
import 'package:wordy/providers/word.dart';

class JsonVocabularyDecoder extends JsonDecoderStrategy {

  @override
  dynamic decode(String toDecode) {
    Map<String, dynamic> json = jsonDecode(toDecode);
    List wordResult = json['results'];
    String name = _getName(json);

    if(wordResult == null || wordResult.length == 0)
      return null;

    for (int i = 0; i < wordResult.length; i++) {
      if (_getExample(wordResult.elementAt(i)) != null) {
        return Word(
            name: name,
            partOfSpeech: EnumStringConverter.stringToEnum(_getPartOfSpeech(wordResult.elementAt(i))),
            definition: _getDefinition(wordResult.elementAt(i)),
            examplePhrase: _getExample(wordResult.elementAt(i)));
      }
    }

    return Word(
        name: name,
        partOfSpeech: EnumStringConverter.stringToEnum(_getPartOfSpeech(wordResult.elementAt(0))),
        definition: _getDefinition(wordResult.elementAt(0)),
        examplePhrase: null);
  }

  String _getName(Map<String, dynamic> result) {
    return result['word'];
  }

  String _getDefinition(Map<String, dynamic> result) {
    return result['definition'];
  }

  String _getPartOfSpeech(Map<String, dynamic> result) {
    if(result['partOfSpeech'] != null)
      return result['partOfSpeech'];
    return 'undef';
  }

  String _getExample(Map<String, dynamic> result) {
    if (result['examples'] != null) {
      return result['examples'][0];
    }

    return null;
  }
}
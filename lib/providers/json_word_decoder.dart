import 'dart:convert';
import 'word.dart';

class JsonWordDecoder {

  static Word decode(String responseBody) {
    Map<String, dynamic> json = jsonDecode(responseBody);
    List wordResult = json['results'];
    String name = _getName(json);

    if(wordResult == null)
      return null;

    for (int i = 0; i < wordResult.length; i++) {
      if (_getExample(wordResult.elementAt(i)) != null) {
        return Word(
            name: name,
            partOfSpeech: _getPartOfSpeech(wordResult.elementAt(i)),
            definition: _getDefinition(wordResult.elementAt(i)),
            examplePhrase: _getExample(wordResult.elementAt(i)));
      }
    }

    return Word(
        name: name,
        partOfSpeech: _getPartOfSpeech(wordResult.elementAt(0)),
        definition: _getDefinition(wordResult.elementAt(0)),
        examplePhrase: null);
  }

  static String _getName(Map<String, dynamic> result) {
    return result['word'];
  }

  static String _getDefinition(Map<String, dynamic> result) {
    return result['definition'];
  }

  static String _getPartOfSpeech(Map<String, dynamic> result) {
    if(result['partOfSpeech'] != null)
      return result['partOfSpeech'];
    return 'undef';
  }

  static String _getExample(Map<String, dynamic> result) {
    if (result['examples'] != null) {
      return result['examples'][0];
    }

    return null;
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wordy/business/json/strategy/json_suggestions_decoder.dart';
import 'package:wordy/business/json/strategy/json_vocabulary_decoder.dart';
import 'package:wordy/constants.dart';

import '../providers/word.dart';

class HttpWords {
  static HttpWords _instance;
  final http.Client _client;
  final JsonVocabularyDecoder _vocabularyDecoder;
  final JsonSuggestionsDecoder _suggestionsDecoder;

  HttpWords._internal()
      : _client = new http.Client(),
        _vocabularyDecoder = JsonVocabularyDecoder(),
        _suggestionsDecoder = JsonSuggestionsDecoder();

  static HttpWords get instance {
    if (_instance == null) _instance = HttpWords._internal();
    return _instance;
  }

  Future<Word> get randomWord async {
    Word toReturn;
    while (toReturn == null) {
      http.Response stateResponse = await _client.get(randomWordUrl);
      dynamic json = jsonDecode(stateResponse.body);
      //the API does return only the string corresponding to the word name
      getWordFromName(json[0]).then((value) => toReturn = value);
    }

    return toReturn;
  }

  Future<List<Word>> getRandomWords(int number) async {
    List<Word> toReturn;
    while (toReturn.length != number) {
      randomWord.then((value) => toReturn.add(value));
    }

    return toReturn;
  }

  Future<List<Word>> getSuggestionsFromWordName(String wordName, int limit) async {
    List<Word> toReturn = [];
    String preparedUrl = '${suggestionWordUrl}sp=$wordName*&max=$limit';
    http.Response stateResponse = await _client.get(preparedUrl);
   _suggestionsDecoder.toDecode = stateResponse.body;
    List<String> suggestionStringList = _suggestionsDecoder.decode();
    if(suggestionStringList != null) {
      for(int i = 0; i < suggestionStringList.length; i++) {
        Word toInsert = await getWordFromName(suggestionStringList.elementAt(i));
        if(toInsert != null)
          toReturn.add(toInsert);
      }
    }

    return toReturn;
  }

  Future<Word> getWordFromName(String name) async {
    http.Response stateResponse = await _client.get(
      '$vocabularyWordUrl$name',
      headers: <String, String>{
        'x-rapidapi-key': x_rapid_key,
        'x_rapid_host': x_rapid_host,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    _vocabularyDecoder.toDecode = stateResponse.body;
    return _vocabularyDecoder.decode();
  }
}

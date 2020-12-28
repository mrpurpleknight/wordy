import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learn_words/constants.dart';

import '../providers/word.dart';
import 'json/json_http_word_decoder.dart';

class HttpWords {
  static HttpWords _instance;
  final http.Client _client;

  HttpWords._internal() : _client = new http.Client();

  static HttpWords get instance {
    if(_instance == null)
      _instance = HttpWords._internal();
    return _instance;
  }

  Future<Word> get randomWord async {
    Word toReturn;
    while(toReturn == null) {
      http.Response stateResponse = await _client.get(randomWordUrl);
      dynamic json = jsonDecode(stateResponse.body);
      //the API does return only the string corresponding to the word name
      _getWordFromName(json[0]).then((value) => toReturn = value);
    }

    return toReturn;
  }

   Future<Word> _getWordFromName(String name) async {
      http.Response stateResponse = await _client.get(
        '$vocabularyWordUrl$name',
        headers: <String, String>{
          'x-rapidapi-key': x_rapid_key,
          'x_rapid_host': x_rapid_host,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      return JsonHttpWordDecoder.decode(stateResponse.body);
  }
}

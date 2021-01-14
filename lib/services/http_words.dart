import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:wordy/services/failure_exception.dart';
import 'package:wordy/services/wordy_client.dart';
import 'package:wordy/services/decoder/json_suggestions_decoder.dart';
import 'package:wordy/services/decoder/json_vocabulary_decoder.dart';
import 'package:wordy/constants.dart';
import 'package:http/http.dart' as http;

import '../providers/word.dart';

class HttpWords {
  static HttpWords _instance;
  final WordyClient _suggestionsClient;
  final WordyClient _randomClient;
  final WordyClient _vocabularyClient;
  final JsonVocabularyDecoder _vocabularyDecoder;
  final JsonSuggestionsDecoder _suggestionsDecoder;
  final StreamController<Word> _controller;

  HttpWords._internal()
      : _suggestionsClient = WordyClient(),
        _randomClient = WordyClient(),
        _vocabularyClient = WordyClient(),
        _vocabularyDecoder = JsonVocabularyDecoder(),
        _suggestionsDecoder = JsonSuggestionsDecoder(),
        _controller = StreamController<Word>.broadcast();

  static HttpWords get instance {
    if (_instance == null) _instance = HttpWords._internal();
    return _instance;
  }

  Stream<Word> get randomStream => _controller.stream;

  Future<Word> get randomWord async {
    Word toReturn;
    try {
      while (toReturn == null) {
        http.Response response =
            await _randomClient.getRequest(randomWordUrl, null);
        dynamic json = jsonDecode(response.body);
        //the API does return only the string corresponding to the word name
        getWordFromName(json[0]).then((value) => toReturn = value);
      }
    } on IOException {
      throw FailureException('No Internet connection');
    }
    return toReturn;
  }

  Stream<Word> getRandomWords() async* {
    while (true) {
      try {
        Word toReturn = await randomWord;
        _controller.sink.add(toReturn);
      } on IOException {
        _controller.add(Word.empty());
      }
    }
  }

  Future<List<Word>> getSuggestionsFromWordName(
      String wordName, int limit) async {
    List<Word> toReturn = [];
    try {
      String preparedUrl = '${suggestionWordUrl}sp=$wordName*&max=$limit';
      http.Response response =
          await _suggestionsClient.getRequest(preparedUrl, null);
      List<String> suggestionStringList =
          _suggestionsDecoder.decode(response.body);
      if (suggestionStringList != null) {
        for (int i = 0; i < suggestionStringList.length; i++) {
          Word toInsert =
              await getWordFromName(suggestionStringList.elementAt(i));
          if (toInsert != null && !toReturn.contains(toInsert))
            toReturn.add(toInsert);
        }
      }
    } on IOException {
      throw FailureException('No Internet connection');
    }

    return toReturn;
  }

  Future<Word> getWordFromName(String name) async {
    http.Response response;
    try {
      response = await _vocabularyClient.getRequest(
        '$vocabularyWordUrl$name',
        <String, String>{
          'x-rapidapi-key': x_rapid_key,
          'x_rapid_host': x_rapid_host,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } on IOException {
      throw FailureException('No Internet connection');
    }

    return _vocabularyDecoder.decode(response.body);
  }
}

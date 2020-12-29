import 'dart:async';
import 'dart:convert';

import 'package:learn_words/business/http_words.dart';

class Word {
  final String name;
  final String partOfSpeech;
  final String definition;
  final String examplePhrase;
  final _controller = StreamController<Word>.broadcast();

  Word({
    this.name,
    this.partOfSpeech,
    this.definition,
    this.examplePhrase,
  });

  static Future<Word> random() async {
    return HttpWords.instance.randomWord;
  }
  
  get stream {
    return _controller.stream;
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
        name: json['name'],
        partOfSpeech: json['partOfSpeech'],
        definition: json['definition'],
        examplePhrase: json['examplePhrase']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'partOfSpeech': partOfSpeech,
      'definition': definition,
      'examplePhrase': examplePhrase,
    };
  }
}

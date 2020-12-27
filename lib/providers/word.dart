import 'package:flutter/material.dart';
import 'package:learn_words/providers/http_words.dart';

class Word {
  final String name;
  final String partOfSpeech;
  final String definition;
  final String examplePhrase;

  Word({
    this.name,
    this.partOfSpeech,
    this.definition,
    this.examplePhrase,
  });

 static Future<Word> random() async{
   return HttpWords.instance.randomWord;
 }
}

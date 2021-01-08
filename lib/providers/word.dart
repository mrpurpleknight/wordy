import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wordy/business/failure_exception.dart';
import 'package:wordy/business/http_words.dart';
import 'package:wordy/constants.dart';

class Word extends Equatable {
  final String name;
  final String partOfSpeech;
  final String definition;
  final String examplePhrase;

  Word.empty() : name = '', partOfSpeech = '', definition = '', examplePhrase = '';

  Word({
    String name,
    this.partOfSpeech,
    this.definition,
    this.examplePhrase,
  }) : this.name = name.substring(0, 1).toUpperCase() + name.substring(1);

  Color get color {
    switch (partOfSpeech) {
      case 'noun':
        return nounColor;
        break;
      case 'verb':
        return verbColor;
        break;
      case 'article':
        return articleColor;
        break;
      case 'pronoun':
        return pronounColor;
        break;
      case 'preposition':
        return prepositionColor;
        break;
      case 'adjective':
        return adjectiveColor;
        break;
      case 'adverb':
        return adverbColor;
        break;
      case 'conjunction':
        return conjunctionColor;
        break;
      default:
        return Colors.black54;
        break;
    }
  }

  String get partOfSpeechAbbreviation {
    switch (partOfSpeech) {
      case 'article':
        return 'art.';
        break;
      case 'pronoun':
        return 'pron.';
        break;
      case 'preposition':
        return 'prep.';
        break;
      case 'adjective':
        return 'adj.';
        break;
      case 'adverb':
        return 'adv.';
        break;
      case 'conjunction':
        return 'conj.';
        break;
      default:
        return partOfSpeech;
        break;
    }
  }

  static Future<Word> random() async {
    return HttpWords.instance.randomWord;
  }

  static Future<List<Word>> randomList(int number) async {
    return HttpWords.instance.getRandomWords(number);
  }

  static Future<Word> byName(String name) async {
    return HttpWords.instance.getWordFromName(name);
  }

  static Future<List<Word>> suggestions(String name, int limit) async{
    return HttpWords.instance.getSuggestionsFromWordName(name, limit);
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

  @override
  List<Object> get props => [name, partOfSpeech, definition, examplePhrase];
}

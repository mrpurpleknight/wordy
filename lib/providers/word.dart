import 'package:equatable/equatable.dart';
import 'package:wordy/business/http_words.dart';

class Word extends Equatable{
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

  String get partOfSpeechAbbreviation {
    switch(partOfSpeech) {
      case 'article':
        return 'art.';
        break;
      case 'pronoun':
        return 'prop.';
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

  static Future<Word> byName(String name) async{
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

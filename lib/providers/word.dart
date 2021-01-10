import 'package:equatable/equatable.dart';
import 'package:wordy/services/decoder/enum_string_converter.dart';
import 'package:wordy/services/decoder/part_of_speech.dart';
import 'package:wordy/services/http_words.dart';

class Word extends Equatable {
  final String _name;
  final PartOfSpeech _partOfSpeech;
  final String _definition;
  final String _examplePhrase;

  Word.empty()
      : _name = '',
        _partOfSpeech = PartOfSpeech.none,
        _definition = '',
        _examplePhrase = '';

  Word({
    String name,
    PartOfSpeech partOfSpeech,
    String definition,
    String examplePhrase,
  })  : this._name = name.substring(0, 1).toUpperCase() + name.substring(1),
        this._partOfSpeech = partOfSpeech,
        this._definition = definition,
        this._examplePhrase = examplePhrase;

  String get name => _name;
  String get partOfSpeech => EnumStringConverter.enumToString(_partOfSpeech);
  PartOfSpeech get partOfSpeechEnum => _partOfSpeech;
  String get definition => _definition;
  String get examplePhrase => _examplePhrase;

  String get partOfSpeechAbbreviation {
    switch (_partOfSpeech) {
      case PartOfSpeech.article:
        return 'art.';
        break;
      case PartOfSpeech.pronoun:
        return 'pron.';
        break;
      case PartOfSpeech.preposition:
        return 'prep.';
        break;
      case PartOfSpeech.adjective:
        return 'adj.';
        break;
      case PartOfSpeech.adverb:
        return 'adv.';
        break;
      case PartOfSpeech.conjunction:
        return 'conj.';
        break;
      default:
        return EnumStringConverter.enumToString(_partOfSpeech);
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

  static Future<List<Word>> suggestions(String name, int limit) async {
    return HttpWords.instance.getSuggestionsFromWordName(name, limit);
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
        name: json['name'],
        partOfSpeech: EnumStringConverter.stringToEnum(json['partOfSpeech']),
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

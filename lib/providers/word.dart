import 'package:equatable/equatable.dart';
import 'package:wordy/services/decoder/enum_string_converter.dart';
import 'package:wordy/services/decoder/part_of_speech.dart';

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

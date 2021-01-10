import 'package:flutter_test/flutter_test.dart';
import 'package:wordy/services/http_words.dart';
import 'package:wordy/providers/word.dart';


main() {
  group('getWordFromName', () {
    test('Test getWordFromName correct', () {
      Word word;
      HttpWords.instance.getWordFromName('random').then((value) {
        word = value;
        expect(word.name, isA<String>());
        expect(word.name, 'random');

        expect(word.partOfSpeech, isA<String>());
        expect(word.partOfSpeech, 'adjective');

        expect(word.definition, isA<String>());

        expect(word.examplePhrase, isA<String>());
      });
    });
    test('Test getWordFromName == null, caused by name', () {
      Word word;
      HttpWords.instance.getWordFromName('hg').then((value) {
        word = value;
        expect(word, null);
      });
    });
    test('Test getWordFromName with examplePhrase == null', () {
      Word word;
      HttpWords.instance.getWordFromName('muslim').then((value) {
        word = value;
        expect(word.name, isA<String>());
        expect(word.name, 'muslim');

        expect(word.partOfSpeech, isA<String>());
        expect(word.partOfSpeech, 'adjective');

        expect(word.definition, isA<String>());

        expect(word.examplePhrase, null);
      });
    });
  });

  group('getRandomWord', () {
    test('Test random word', () {
      Word word;
      HttpWords.instance.randomWord.then((value) {
        word = value;
        expect(word.name, isA<String>());

        expect(word.partOfSpeech, isA<String>());

        expect(word.definition, isA<String>());
      });
    });
  });
}

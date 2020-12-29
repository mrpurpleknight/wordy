import 'dart:convert';
import 'dart:io';

import 'package:learn_words/repository/repository.dart';
import 'package:path_provider/path_provider.dart';
import '../providers/word.dart';

class WordsRepository extends Repository<Word>{
  static WordsRepository _instance;

  WordsRepository._internal();

  static WordsRepository get instance {
    if(_instance == null)
      _instance = WordsRepository._internal();
    return _instance;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _getFileLocationFromWord(Word word) async{
    final path = await _localPath;
    return File('$path/${word.name}.json');
  }

  @override
  Future<List<Word>> readAll() async{
    final List<Word> toReturn = [];
    String directory = await _localPath;
    List<FileSystemEntity> list = Directory('$directory/').listSync();
    for(int i = 0; i < list.length; i++) {
      if(list.elementAt(i) is File && list.elementAt(i).path.contains('.json')) {
        final File file = File((list.elementAt(i) as File).path);
        Word toInsert = Word.fromJson(jsonDecode(file.readAsStringSync()));
        toReturn.add(toInsert);
      }
    }
    return toReturn;
  }

  @override
  void write(Word word) async{
    try {
      final File file = await _getFileLocationFromWord(word);

      return file.writeAsStringSync(jsonEncode(word));
    }
    catch(e) {
      print(e);
    }
  }
}
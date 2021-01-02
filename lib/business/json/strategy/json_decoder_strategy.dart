import 'package:learn_words/providers/word.dart';


abstract class JsonDecoderStrategy {
  String toDecode;

  dynamic decode();
}
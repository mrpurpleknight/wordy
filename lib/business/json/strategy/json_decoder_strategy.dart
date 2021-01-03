import 'package:wordy/providers/word.dart';


abstract class JsonDecoderStrategy {
  String toDecode;

  dynamic decode();
}
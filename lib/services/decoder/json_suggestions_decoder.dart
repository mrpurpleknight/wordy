import 'dart:convert';

import 'package:wordy/business/decoder/json_decoder_strategy.dart';

class JsonSuggestionsDecoder extends JsonDecoderStrategy {

  @override
  dynamic decode(String toDecode) {
    List<dynamic> json = jsonDecode(toDecode);

    List<String> toReturn = [];

    if(json == null || json.length == 0)
      return null;

    for(int i = 0; i < json.length; i++) {
      toReturn.add(json.elementAt(i)['word']);
    }

    return toReturn;
  }
}
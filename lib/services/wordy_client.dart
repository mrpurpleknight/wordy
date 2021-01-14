import 'package:http/http.dart' as http;

class WordyClient {
  http.Client _client;

  WordyClient() : _client = http.Client();

  Future<http.Response> getRequest(
      String url, Map<String, String> headers) async {
    if (headers != null) {
      return _client.get(url, headers: headers);
    } else {
      return _client.get(url);
    }
  }

  void close() {
    _client.close();
  }
}

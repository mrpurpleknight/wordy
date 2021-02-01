import 'package:http/http.dart' as http;
import 'package:wordy/services/failure_exception.dart';

class WordyClient {
  http.Client _client;

  WordyClient() : _client = http.Client();

  Future<http.Response> getRequest(
      String url, Map<String, String> headers) async {
    try {
      if (headers != null)
        return _client.get(url, headers: headers);
      else
        return _client.get(url);
    } catch (e) {
      throw FailureException('No Internet connection');
    }
  }

  void close() {
    _client.close();
  }
}

import 'dart:io';

import 'package:http/http.dart' as http;

import 'failure.dart';

class HttpClient {
  final http.Client _client;

  HttpClient() : _client = http.Client();

  Future<http.Response> getRequest(
      String url, Map<String, String> headers) async {
    try {
      if (headers != null) {
        return _client.get(url, headers: headers);
      } else {
        return _client.get(url);
      }
    } on SocketException {
      throw Failure("No Internet Connection");
    } on HttpException {
      throw Failure('Service not available');
    } on FormatException {
      throw Failure('Fatal error');
    }
  }

  void close() {
    _client.close();
  }
}

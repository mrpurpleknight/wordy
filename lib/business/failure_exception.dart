class FailureException implements Exception{
  String _message;

  FailureException(this._message);

  @override
  String toString() {
    return _message;
  }
}
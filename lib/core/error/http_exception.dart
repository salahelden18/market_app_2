class HttpException implements Exception {
  final String message;
  int? statusCode;
  HttpException(this.message, {this.statusCode});

  @override
  String toString() {
    return message;
  }
}

import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'http_exception.dart';

abstract class HttpFailure {
  final String message;
  final String? localizedMessage;

  const HttpFailure(this.message, {this.localizedMessage});
}

class ServerHttpFailure extends HttpFailure {
  const ServerHttpFailure(String message, {String? localizedMessage})
      : super(message, localizedMessage: localizedMessage);
}

class InternalAppHttpFailure extends HttpFailure {
  const InternalAppHttpFailure(super.message);
}

class NoInternetConnectionHttpFailure extends HttpFailure {
  const NoInternetConnectionHttpFailure(super.message);
}

class TimeoutHttpFailure extends HttpFailure {
  const TimeoutHttpFailure(super.message);
}

class NoContenHttptFailure extends HttpFailure {
  const NoContenHttptFailure(super.message);
}

class NotAuthorizedHttpFailure extends HttpFailure {
  const NotAuthorizedHttpFailure(super.message);
}

Either<HttpFailure, T> handleException<T>(dynamic exception) {
  if (exception is HttpException) {
    return left(ServerHttpFailure(exception.message));
  } else if (exception is SocketException) {
    return left(
        const NoInternetConnectionHttpFailure('No Internet Connection'));
  } else if (exception is TimeoutException) {
    return left(const TimeoutHttpFailure('Operation timed out'));
  } else {
    print(exception);
    return left(const InternalAppHttpFailure('Something Went Wrong'));
  }
}

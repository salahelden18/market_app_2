import 'package:dartz/dartz.dart';

import '../error/http_failure.dart';

abstract class HttpServiceInterface {
  Future<Either<HttpFailure, T?>> get<T>({
    required String url,
    String? query,
    required T? Function(dynamic) fromJson,
    Map<String, dynamic> headers = const {},
    bool requireToken = true,
  });

  Future<Either<HttpFailure, T?>> post<T>({
    required String url,
    String? query,
    required T? Function(dynamic) fromJson,
    Map<String, dynamic>? body,
    Map<String, dynamic> headers = const {},
    bool requireToken = true,
  });

  Future<Either<HttpFailure, T?>> patch<T>({
    required String url,
    String? query,
    required T? Function(dynamic) fromJson,
    Map<String, dynamic>? body,
    Map<String, dynamic> headers = const {},
    bool requireToken = true,
  });

  Future<Either<HttpFailure, T?>> request<T>({
    required String url,
    required String method,
    required Map<String, dynamic> fields,
    required T? Function(dynamic p1) fromJson,
  });

  Future<Either<HttpFailure, T?>> delete<T>({
    required String url,
    String? query,
    required T? Function(dynamic) fromJson,
    Map<String, dynamic>? body,
    Map<String, dynamic> headers = const {},
    bool requireToken = true,
  });
}

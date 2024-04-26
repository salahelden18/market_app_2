import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../constants/string_constants.dart';
import '../error/exception_model.dart';
import '../error/http_exception.dart';
import '../error/http_failure.dart';
import 'http_service_interface.dart';
import 'shared_preferences_service.dart';

class HttpService extends HttpServiceInterface {
  final SharedPreferencesService _sharedPreferencesService;

  HttpService(this._sharedPreferencesService);

  @override
  Future<Either<HttpFailure, T?>> get<T>({
    required String url,
    String? query,
    required T? Function(dynamic p1) fromJson,
    Map<String, dynamic> headers = const {},
    bool requireToken = true,
  }) async {
    try {
      final urlParsed = Uri.parse('$url${query != null ? '?$query' : ''}');
      print(urlParsed);
      final requestHeaders = await _buildRequestHeader(headers, requireToken);

      final response = await http
          .get(
        urlParsed,
        headers: requestHeaders,
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'Sorry, the operation took too long to complete. Please try again!');
      });

      if (response.statusCode == 204) {
        return right(null);
      }

      if (response.statusCode == 401) {
        // here we should log the user out
        return right(null);
      }

      final decodedResponse = jsonDecode(response.body);
      print(decodedResponse);

      if (response.statusCode > 299) {
        final error = ExceptionModel.fromJson(decodedResponse);
        throw HttpException(error.message);
      }

      final parsedModel = fromJson(decodedResponse);

      return right(parsedModel);
    } catch (error) {
      print(error);
      return handleException(error);
    }
  }

  @override
  Future<Either<HttpFailure, T?>> post<T>(
      {required String url,
      String? query,
      required T? Function(dynamic p1) fromJson,
      Map<String, dynamic>? body,
      Map<String, dynamic> headers = const {},
      bool requireToken = true}) async {
    try {
      final urlParsed = Uri.parse('$url${query != null ? '?$query' : ''}');

      final requestHeaders = await _buildRequestHeader(headers, requireToken);

      final response = await http
          .post(
        body: body != null ? json.encode(body) : null,
        urlParsed,
        headers: requestHeaders,
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'Sorry, the operation took too long to complete. Please try again!');
      });

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode > 299) {
        final error = ExceptionModel.fromJson(decodedResponse);
        throw HttpException(error.message);
      }

      final parsedModel = fromJson(decodedResponse);

      return right(parsedModel);
    } catch (error) {
      print(error);
      return handleException(error);
    }
  }

  @override
  Future<Either<HttpFailure, T?>> patch<T>(
      {required String url,
      String? query,
      required T? Function(dynamic p1) fromJson,
      Map<String, dynamic>? body,
      Map<String, dynamic> headers = const {},
      bool requireToken = true}) async {
    try {
      final urlParsed = Uri.parse('$url${query != null ? '?$query' : ''}');
      print(urlParsed);

      final requestHeaders = await _buildRequestHeader(headers, requireToken);

      final response = await http
          .patch(
        body: body != null ? json.encode(body) : null,
        urlParsed,
        headers: requestHeaders,
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'Sorry, the operation took too long to complete. Please try again!');
      });

      final decodedResponse = jsonDecode(response.body);

      print(decodedResponse);

      if (response.statusCode > 299) {
        final error = ExceptionModel.fromJson(decodedResponse);
        throw HttpException(error.message);
      }

      final parsedModel = fromJson(decodedResponse);

      return right(parsedModel);
    } catch (error) {
      print(error);
      return handleException(error);
    }
  }

  @override
  Future<Either<HttpFailure, T?>> delete<T>(
      {required String url,
      String? query,
      required T? Function(dynamic p1) fromJson,
      Map<String, dynamic>? body,
      Map<String, dynamic> headers = const {},
      bool requireToken = true}) async {
    try {
      final urlParsed = Uri.parse('$url${query != null ? '?$query' : ''}');
      print(urlParsed);

      final requestHeaders = await _buildRequestHeader(headers, requireToken);

      final response = await http
          .delete(
        body: body != null ? json.encode(body) : null,
        urlParsed,
        headers: requestHeaders,
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException(
            'Sorry, the operation took too long to complete. Please try again!');
      });

      // here means that it is deleted successfully
      if (response.statusCode == 204) {
        return right(null);
      }
      final decodedResponse = jsonDecode(response.body);

      print(decodedResponse);

      if (response.statusCode > 299) {
        final error = ExceptionModel.fromJson(decodedResponse);
        throw HttpException(error.message);
      }

      final parsedModel = fromJson(decodedResponse);
      return right(parsedModel);
    } catch (error) {
      print(error);
      return handleException(error);
    }
  }

  @override
  Future<Either<HttpFailure, T?>> request<T>({
    required String url,
    required String method,
    required T? Function(dynamic p1) fromJson,
    required Map<String, dynamic> fields,
  }) async {
    try {
      final parsedUrl = Uri.parse(url);
      final request = http.MultipartRequest(method, parsedUrl);

      print(parsedUrl);
      print(fields);

      var headers = await _buildRequestHeader({}, true);

      for (var header in headers.entries) {
        request.headers[header.key] = header.value;
      }
      print(fields);
      // Add form fields
      for (var field in fields.entries) {
        //  if the field is file
        if (field.value is File) {
          request.files.add(await http.MultipartFile.fromPath(
            field.key, // Field name for the file
            (field.value as File).path, // Path to the file on the device
          ));
          // is it is list of files
        } else if (field.value is List<File>) {
          for (var fileSpecific in field.value as List<File>) {
            request.files.add(await http.MultipartFile.fromPath(
              field.key, // Field name for the file
              fileSpecific.path, // Path to the file on the device
            ));
          }
          // if it is normal field
        } else {
          request.fields[field.key] = field.value;
        }
      }

      // Send the request
      final response = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw TimeoutException(
              'Sorry, the operation took too long to complete. Please try again!');
        },
      );

      print(response.statusCode);

      var bytesToString = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(bytesToString);

      print(decodedResponse);

      if (response.statusCode > 299) {
        final error = ExceptionModel.fromJson(decodedResponse);
        throw HttpException(error.message);
      }

      final parsedModel = fromJson(decodedResponse);

      print(parsedModel);

      return right(parsedModel);
    } catch (error) {
      print(error);
      return handleException(error);
    }
  }

  Future<Map<String, String>> _buildRequestHeader(
      Map<String, dynamic> headers, bool requireToken,
      [bool isForm = false]) async {
    Map<String, String> requestHeaders = {
      'Content-Type': isForm ? 'multipart/form-data' : "application/json",
      "Access-Control-Allow-Origin": "*",
      'Accept': '*/*',
      ...headers,
    };

    if (requireToken) {
      String? token = await _sharedPreferencesService
          .getData<String>(StringConstants.token);
      if (token != null) {
        requestHeaders['Authorization'] = 'Bearer $token';
      }
    }

    return requestHeaders;
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

enum Method { post, get, put, patch, delete }

typedef E<T> = Future<Either<String, T>>;

String retStrKey = 'ret_str';
String messageKey = 'message';
Map<String, String> headerMap = {
  'content-type': 'application/json',
  'accept': 'application/json',
};

class DioClient {
  final Dio dio;

  DioClient({Dio? dioOverride})
    : dio = dioOverride ?? Dio(BaseOptions(headers: headerMap)) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          logPrint: (obj) => log(obj.toString(), name: 'DioClient'),
        ),
      );
    }
  }

  E<T> apiRequest<T>({
    required String url,
    required Method method,
    Map<String, dynamic>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    // Move token logic to an Interceptor
    final token = "";
    final defaultHeaders = Map<String, dynamic>.from(headers ?? headerMap);

    if (token.isNotEmpty) {
      defaultHeaders['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await dio.request(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          method: method.name.toUpperCase(),
          headers: defaultHeaders,
        ),
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return right(response.data as T);
      } else {
        return left(_extractErrorMessage(response.data));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return left(_extractErrorMessage(e.response?.data));
      }
      return left(e.message ?? e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data is Map) {
      return (data[retStrKey] ?? data[messageKey] ?? data.toString()).toString();
    }
    return data?.toString() ?? 'Unknown Error';
  }
}

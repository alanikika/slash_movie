import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final String apiBaseUrl;

  DioClient({required this.apiBaseUrl});

  Dio get dio => _getDio();

  Dio _getDio() {
    debugPrint("=== dio called");
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    Dio dio = Dio(options);

    return dio;
  }
}

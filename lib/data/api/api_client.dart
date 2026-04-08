import 'package:dio/dio.dart';

import 'apis.dart';

class APIClient {
  APIClient();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Apis.BaseURL,
      connectTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 30000),
      headers: {Headers.acceptHeader: Headers.jsonContentType},
      contentType: Headers.jsonContentType,
      validateStatus: (status) => status! < 500,
    ),
  );
}

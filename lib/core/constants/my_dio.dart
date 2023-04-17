import 'package:dio/dio.dart';

final dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.200.41:8080",
      contentType: "application/json; charset=utf-8",
    )
);
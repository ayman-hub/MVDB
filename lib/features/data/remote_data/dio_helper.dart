import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:tmdb_task/error/dio_error_exception.dart';
import 'package:tmdb_task/features/data/remote_data/core.dart';

class DioHelper {
  late Response _response;
  Dio _dio = new Dio();

  Future<dynamic> get(Map<String, dynamic> post,
      {String path = '',
      required Function(Map<String, dynamic> data) onSuccess}) async {
    try {
      _dio.options.connectTimeout = 10000; //5s
      _dio.options.receiveTimeout = 10000;
      Map<String, dynamic> query = {'api_key': apiKey()};
      query.addAll(post);
      _response = await _dio.get(apiUrl() + path,
          queryParameters: query,
          options: Options(headers: {
            'Content-Type': 'application/json',
          }));
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        //print("response in dio: ${_response.data}");
        return onSuccess(_response.data);
      } else {
        return _response.data.toString();
      }
    } catch (error) {
      String msg = '';
      if (error is DioError) {
        DioExceptions dioExceptions = DioExceptions.fromDioError(error);
        msg = dioExceptions.message.toString();
      } else {
        msg = error.toString();
      }
      return msg;
    }
  }

  Future<dynamic> post(Map<String, dynamic> post,
      {required Function(Map<String, dynamic> data) onSuccess,
      String path = ''}) async {
    try {
      _dio.options.connectTimeout = 10000; //5s
      _dio.options.receiveTimeout = 10000;
      _response = await _dio.post(apiUrl() + path,
          data: post,
          queryParameters: {'api_key': apiKey()},
          options: Options(headers: {
            'Content-Type': 'application/json',
          }));
      if (_response.statusCode == 200 || _response.statusCode == 201) {
        return onSuccess(_response.data);
      } else {
        return _response.data.toString();
      }
    } catch (error) {
      String msg = '';
      if (error is DioError) {
        DioExceptions dioExceptions = DioExceptions.fromDioError(error);
        msg = dioExceptions.message.toString();
      } else {
        msg = error.toString();
      }
      return msg.toString();
    }
  }
}

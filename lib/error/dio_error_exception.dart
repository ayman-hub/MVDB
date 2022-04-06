import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    print('dioError :: ${dioError.toString()}');
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(dioError.response!.statusCode, dioError.response?.data??{});
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  late String message;

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 401:
        return 'invalid user name or password';
      case 400:
        print('status code :: 400');
        return 'Bad request';
      case 404:
        print('status code :: 404');
        return 'status code :: 404 ${error["status_message"]}';
      case 500:
        print('status code :: 500');
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

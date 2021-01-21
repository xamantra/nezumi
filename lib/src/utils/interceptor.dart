import 'package:dio/dio.dart';

class HttpInterceptor extends Interceptor {
  Future<RequestOptions> onRequest(RequestOptions options) async {
    print('[Request] ${options.uri.toString()}');
    return options;
  }

  Future<Response> onResponse(Response response) async {
    print('[Response (${response.statusCode})] ${response.request.uri.toString()}');
    return response;
  }

  Future<DioError> onError(DioError error) async {
    print('[${error.type}] ${error.message}');
    return error;
  }
}

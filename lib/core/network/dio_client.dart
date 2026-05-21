import 'package:book_buddy/core/constants/app_constants.dart';
import 'package:book_buddy/core/error/exceptions.dart';
import 'package:book_buddy/flavor_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: FlavorConfig.instance.booksBaseUrl,
      connectTimeout: const Duration(
        seconds: AppConstants.connectTimeoutSeconds,
      ),
      receiveTimeout: const Duration(
        seconds: AppConstants.receiveTimeoutSeconds,
      ),
      queryParameters: {
        'key': FlavorConfig.instance.booksApiKey,
      },
    ),
  );

  // Logging only in dev — never log in prod
  if (FlavorConfig.instance.isDev && kDebugMode) {
    dio.interceptors.add(_LoggingInterceptor());
  }

  dio.interceptors.add(_ErrorInterceptor());

  return dio;
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return handler.reject(
          _toDioException(
            err,
            const NetworkException('Request timed out'),
          ),
        );
      case DioExceptionType.connectionError:
        return handler.reject(
          _toDioException(
            err,
            const NetworkException(),
          ),
        );
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = _messageFromStatus(statusCode);
        return handler.reject(
          _toDioException(
            err,
            ServerException(message: message, statusCode: statusCode ?? 500),
          ),
        );
      case DioExceptionType.badCertificate:
        final statusCode = err.response?.statusCode;
        final message = _messageFromStatus(statusCode);
        return handler.reject(
          _toDioException(
            err,
            ServerException(message: message, statusCode: statusCode ?? 500),
          ),
        );
      case DioExceptionType.cancel:
        final statusCode = err.response?.statusCode;
        final message = _messageFromStatus(statusCode);
        return handler.reject(
          _toDioException(
            err,
            ServerException(message: message, statusCode: statusCode ?? 500),
          ),
        );
      case DioExceptionType.unknown:
        final statusCode = err.response?.statusCode;
        final message = _messageFromStatus(statusCode);
        return handler.reject(
          _toDioException(
            err,
            ServerException(message: message, statusCode: statusCode ?? 500),
          ),
        );
    }
  }

  DioException _toDioException(DioException original, Exception cause) {
    return DioException(
      requestOptions: original.requestOptions,
      error: cause,
      type: original.type,
      response: original.response,
    );
  }

  String _messageFromStatus(int? statusCode) => switch (statusCode) {
    null => 'Server error',
    400 => 'Bad request',
    401 => 'Unauthorized — check your API key',
    403 => 'Forbidden',
    404 => 'Resource not found',
    429 => 'Too many requests',
    >= 500 => 'Server error, please try again later',
    _ => 'Unexpected error',
  };
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('[DIO] --> ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint(
      '[DIO] <-- ${response.statusCode} ${response.requestOptions.uri}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('[DIO] ERR ${err.type} ${err.requestOptions.uri}');
    handler.next(err);
  }
}

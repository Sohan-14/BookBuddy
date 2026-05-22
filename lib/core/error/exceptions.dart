/// Base exception class
abstract class AppException implements Exception {
  const AppException(this.message, [this.code]);
  final String message;
  final String? code;

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No Internet Connection']);
}

class ServerException extends AppException {

  const ServerException({
    required String message,
    required this.statusCode,
  }) : super(message);
  final int? statusCode;

  @override
  String toString() =>
      'ServerException(statusCode: $statusCode, message: $message)';
}
class RequestTimeoutException extends AppException {
  const RequestTimeoutException([super.message = 'Request timed out']);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Session expired. Please log in again']);
}

class ForbiddenException extends AppException {
  const ForbiddenException([super.message = 'You do not have permission to do this']);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Resource not found']);
}

class ParseException extends AppException {
  const ParseException([super.message = 'Parsing Error']);
}

class CacheException extends AppException {
  const CacheException([super.message = 'Cache Error']);
}


class UnknownException extends AppException {
  const UnknownException([super.message = 'An unexpected error occurred']);
}

class BadRequestException extends AppException {
  const BadRequestException([super.message = 'Invalid request parameters']);
}

class ConflictException extends AppException {
  const ConflictException([super.message = 'Resource conflict. Please try again']);
}

class TooManyRequestsException extends AppException {
  const TooManyRequestsException([super.message = 'Too many attempts. Please try again later']);
}

class ServiceUnavailableException extends AppException {
  const ServiceUnavailableException([super.message = 'Service temporarily unavailable']);
}

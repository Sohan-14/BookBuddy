import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message, [this.code]);

  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

// ─── Network & Connectivity ───────────────────────────────
class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'No internet connection'})
    : super(message);
}

class RequestTimeoutFailure extends Failure {
  const RequestTimeoutFailure({String message = 'Request timed out'})
    : super(message);
}

// ─── HTTP Status Failures ─────────────────────────────────
class ServerFailure extends Failure {
  const ServerFailure({
    String message = 'Server error',
    this.statusCode,
    String? code,
  }) : super(message, code);

  final int? statusCode;

  @override
  List<Object?> get props => [message, code, statusCode];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    String message = 'Session expired. Please log in again',
  }) : super(message);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({
    String message = 'You do not have permission to do this',
  }) : super(message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = 'Resource not found'})
    : super(message);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({String message = 'Invalid request parameters'})
    : super(message);
}

class ConflictFailure extends Failure {
  const ConflictFailure({
    String message = 'Resource conflict. Please try again',
  }) : super(message);
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure({
    String message = 'Too many attempts. Please try again later',
  }) : super(message);
}

// ─── Local & Parsing ──────────────────────────────────────
class CacheFailure extends Failure {
  const CacheFailure({String message = 'Cache error'}) : super(message);
}

class ParseFailure extends Failure {
  const ParseFailure({String message = 'Failed to parse data'})
    : super(message);
}

// ─── Business Logic ───────────────────────────────────────
class ValidationFailure extends Failure {
  const ValidationFailure({required String message}) : super(message);
}

// ─── Fallback ─────────────────────────────────────────────
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({String message = 'An unexpected error occurred'})
    : super(message);
}

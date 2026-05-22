import 'package:book_buddy/core/error/exceptions.dart';
import 'package:book_buddy/core/error/failures.dart';

class FailureMapper {
  /// Maps data-layer exceptions to domain-layer failures
  static Failure map(Exception exception) {
    switch (exception) {
      // Network
      case NetworkException():
        return const NetworkFailure();

      case RequestTimeoutException():
        return const RequestTimeoutFailure();

      // HTTP Status Codes
      case UnauthorizedException():
        return const UnauthorizedFailure();

      case ForbiddenException():
        return const ForbiddenFailure();

      case NotFoundException():
        return const NotFoundFailure();

      case BadRequestException():
        return const BadRequestFailure();

      case ConflictException():
        return const ConflictFailure();

      case TooManyRequestsException():
        return const TooManyRequestsFailure();

      case ServiceUnavailableException():
        return ServerFailure(
          message: exception.message,
        );

      case final ServerException e:
        return ServerFailure(
          message: e.message,
          code: e.code,
        );

      // Local & Parsing
      case CacheException():
        return const CacheFailure();

      case ParseException():
        return const ParseFailure();

      // Fallback
      default:
        return const UnexpectedFailure();
    }
  }
}

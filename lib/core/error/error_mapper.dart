import 'package:book_buddy/core/error/exceptions.dart';
import 'package:book_buddy/core/error/failures.dart';

class ErrorMapper {
  const ErrorMapper._();

  static Failure map(Object error) {
    if (error is Failure) return error;

    if (error is AppException) {
      return switch (error) {
        NetworkException() => NetworkFailure(message: error.message),
        RequestTimeoutException() => RequestTimeoutFailure(
          message: error.message,
        ),
        ServerException() => ServerFailure(
          message: error.message,
          statusCode: error.statusCode,
          code: error.code,
        ),
        UnauthorizedException() => UnauthorizedFailure(message: error.message),
        ForbiddenException() => ForbiddenFailure(message: error.message),
        NotFoundException() => NotFoundFailure(message: error.message),
        BadRequestException() => BadRequestFailure(message: error.message),
        ConflictException() => ConflictFailure(message: error.message),
        TooManyRequestsException() => TooManyRequestsFailure(
          message: error.message,
        ),
        ServiceUnavailableException() => ServerFailure(
          message: error.message,
          code: error.code,
        ),
        ParseException() => ParseFailure(message: error.message),
        CacheException() => CacheFailure(message: error.message),
        UnknownException() => UnexpectedFailure(message: error.message),
        AppException() => UnexpectedFailure(message: error.message),
      };
    }

    return UnexpectedFailure(message: error.toString());
  }
}

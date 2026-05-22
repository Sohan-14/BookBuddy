import 'package:book_buddy/core/constants/api_constants.dart';
import 'package:book_buddy/core/error/exceptions.dart';
import 'package:book_buddy/features/books/data/models/book_model.dart';
import 'package:dio/dio.dart';

abstract interface class BookRemoteDatasource {
  Future<({List<BookModel> books, int totalItems})> getBooks({
    required String query,
    required int startIndex,
    required int maxResults,
  });
}

class BookRemoteDatasourceImpl implements BookRemoteDatasource {
  const BookRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<({List<BookModel> books, int totalItems})> getBooks({
    required String query,
    required int startIndex,
    required int maxResults,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.volumesEndpoint,
        queryParameters: {
          'q': query,
          'startIndex': startIndex,
          'maxResults': maxResults,
          'printType': 'books',
          'langRestrict': 'en',
        },
      );

      final data = response.data;

      if (data == null) {
        throw const ServerException(
          message: 'Empty response from server',
          statusCode: null,
        );
      }

      final totalItems = data['totalItems'] as int? ?? 0;
      final items = data['items'] as List<dynamic>? ?? [];

      final books = items
          .whereType<Map<String, dynamic>>()
          .map(BookModel.fromJson)
          .where((book) => book.id.isNotEmpty && book.title != 'Untitled')
          .toList();

      return (books: books, totalItems: totalItems);
    } on DioException catch (e) {
      final cause = e.error;
      if (cause is NetworkException) throw cause;
      if (cause is ServerException) throw cause;
      throw ServerException(
        message: e.message ?? 'Request failed',
        statusCode: e.response?.statusCode,
      );
    }
  }
}

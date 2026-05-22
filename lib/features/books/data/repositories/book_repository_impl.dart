import 'package:book_buddy/core/error/exceptions.dart';
import 'package:book_buddy/core/network/network_info.dart';
import 'package:book_buddy/features/books/data/datasources/book_remote_datasource.dart';
import 'package:book_buddy/features/books/data/mappers/book_mapper.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/books/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  const BookRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  final BookRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  @override
  Future<({List<BookEntity> books, int totalItems})> getBooks({
    required String query,
    required int startIndex,
    required int maxResults,
  }) async {
    final connected = await networkInfo.isConnected;
    if (!connected) {
      throw const NetworkException();
    }

    try {
      final result = await remoteDatasource.getBooks(
        query: query,
        startIndex: startIndex,
        maxResults: maxResults,
      );

      return (
        books: BookMapper.toEntityList(result.books),
        totalItems: result.totalItems,
      );
    } on NetworkException catch (e) {
      throw NetworkException(e.message);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }
}

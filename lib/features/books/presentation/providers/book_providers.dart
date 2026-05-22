import 'package:book_buddy/core/providers/core_providers.dart';
import 'package:book_buddy/features/books/data/datasources/book_remote_datasource.dart';
import 'package:book_buddy/features/books/data/repositories/book_repository_impl.dart';
import 'package:book_buddy/features/books/domain/repositories/book_repository.dart';
import 'package:book_buddy/features/books/domain/usecases/get_books_usecase.dart';
import 'package:book_buddy/features/books/domain/usecases/search_books_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_providers.g.dart';

@Riverpod(keepAlive: true)
BookRemoteDatasource bookRemoteDatasource(Ref ref) =>
    BookRemoteDatasourceImpl(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
BookRepository bookRepository(Ref ref) => BookRepositoryImpl(
  remoteDatasource: ref.watch(bookRemoteDatasourceProvider),
  networkInfo: ref.watch(networkInfoProvider),
);

@Riverpod(keepAlive: true)
GetBooksUseCase getBooksUseCase(Ref ref) =>
    GetBooksUseCase(ref.watch(bookRepositoryProvider));

@Riverpod(keepAlive: true)
SearchBooksUseCase searchBooksUseCase(Ref ref) =>
    SearchBooksUseCase(ref.watch(bookRepositoryProvider));

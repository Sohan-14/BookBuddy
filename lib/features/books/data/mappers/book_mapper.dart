import 'package:book_buddy/features/books/data/models/book_model.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';

class BookMapper {
  const BookMapper._();

  static BookEntity toEntity(BookModel model) => BookEntity(
    id: model.id,
    title: model.title,
    authors: model.authors,
    description: model.description,
    thumbnailUrl: model.thumbnailUrl,
    publisher: model.publisher,
    publishedDate: model.publishedDate,
    pageCount: model.pageCount,
    categories: model.categories,
    averageRating: model.averageRating,
    ratingsCount: model.ratingsCount,
    infoLink: model.infoLink,
  );

  static List<BookEntity> toEntityList(List<BookModel> models) =>
      models.map(toEntity).toList();

  static BookModel toModel(BookEntity entity) => BookModel(
    id: entity.id,
    title: entity.title,
    authors: entity.authors,
    description: entity.description,
    thumbnailUrl: entity.thumbnailUrl,
    publisher: entity.publisher,
    publishedDate: entity.publishedDate,
    pageCount: entity.pageCount,
    categories: entity.categories,
    averageRating: entity.averageRating,
    ratingsCount: entity.ratingsCount,
    infoLink: entity.infoLink,
  );
}

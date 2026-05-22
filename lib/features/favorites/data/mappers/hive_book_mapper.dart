import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/favorites/data/models/hive_book_model.dart';

class HiveBookMapper {
  const HiveBookMapper._();

  static BookEntity toEntity(HiveBookModel model) => BookEntity(
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

  static HiveBookModel toHiveModel(BookEntity entity) => HiveBookModel(
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

  static List<BookEntity> toEntityList(List<HiveBookModel> models) =>
      models.map(toEntity).toList();
}

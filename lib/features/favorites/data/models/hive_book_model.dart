import 'package:hive_ce/hive.dart';

part 'hive_book_model.g.dart';

@HiveType(typeId: 0)
class HiveBookModel extends HiveObject {
  HiveBookModel({
    required this.id,
    required this.title,
    required this.authors,
    required this.categories, this.description,
    this.thumbnailUrl,
    this.publisher,
    this.publishedDate,
    this.pageCount,
    this.averageRating,
    this.ratingsCount,
    this.infoLink,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<String> authors;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? thumbnailUrl;

  @HiveField(5)
  String? publisher;

  @HiveField(6)
  String? publishedDate;

  @HiveField(7)
  int? pageCount;

  @HiveField(8)
  List<String> categories;

  @HiveField(9)
  double? averageRating;

  @HiveField(10)
  int? ratingsCount;

  @HiveField(11)
  String? infoLink;
}

import 'package:book_buddy/core/constants/api_constants.dart';

class BookModel {
  const BookModel({
    required this.id,
    required this.title,
    this.authors = const [],
    this.description,
    this.thumbnailUrl,
    this.publisher,
    this.publishedDate,
    this.pageCount,
    this.categories = const [],
    this.averageRating,
    this.ratingsCount,
    this.infoLink,
  });
  factory BookModel.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] as Map<String, dynamic>? ?? {};
    final imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>?;

    final rawThumbnail =
        imageLinks?['thumbnail'] as String? ??
        imageLinks?['smallThumbnail'] as String?;

    return BookModel(
      id: json['id'] as String? ?? '',
      title: volumeInfo['title'] as String? ?? 'Untitled',
      authors:
          (volumeInfo['authors'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      description: volumeInfo['description'] as String?,
      thumbnailUrl: rawThumbnail != null
          ? ApiConstants.fixThumbnailUrl(rawThumbnail)
          : null,
      publisher: volumeInfo['publisher'] as String?,
      publishedDate: volumeInfo['publishedDate'] as String?,
      pageCount: volumeInfo['pageCount'] as int?,
      categories:
          (volumeInfo['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      averageRating: (volumeInfo['averageRating'] as num?)?.toDouble(),
      ratingsCount: volumeInfo['ratingsCount'] as int?,
      infoLink: volumeInfo['infoLink'] as String?,
    );
  }

  final String id;
  final String title;
  final List<String> authors;
  final String? description;
  final String? thumbnailUrl;
  final String? publisher;
  final String? publishedDate;
  final int? pageCount;
  final List<String> categories;
  final double? averageRating;
  final int? ratingsCount;
  final String? infoLink;

  Map<String, dynamic> toJson() => {
    'id': id,
    'volumeInfo': {
      'title': title,
      'authors': authors,
      'description': description,
      'imageLinks': thumbnailUrl != null ? {'thumbnail': thumbnailUrl} : null,
      'publisher': publisher,
      'publishedDate': publishedDate,
      'pageCount': pageCount,
      'categories': categories,
      'averageRating': averageRating,
      'ratingsCount': ratingsCount,
      'infoLink': infoLink,
    },
  };
}

class BookEntity {
  const BookEntity({
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

  String get authorsDisplay =>
      authors.isEmpty ? 'Unknown Author' : authors.join(', ');

  String get shortDescription {
    if (description == null || description!.isEmpty) {
      return 'No description available.';
    }
    if (description!.length <= 200) return description!;
    return '${description!.substring(0, 200)}...';
  }
}

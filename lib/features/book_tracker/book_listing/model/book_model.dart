import '../../../../core/constants/app_constants.dart';
import '../../../../core/models/pagination_model.dart';
import '../../../../shared/helpers/json_parser.dart';

class BookModel {
  final String id;
  final String title;
  final List<String> authors;
  final String workKey;
  final String coverId;
  final bool isAvailable;
  final bool isFullTextAvailable;
  final BookAccessType accessType;

  BookModel({
    this.id = '',
    this.title = '',
    this.authors = const [],
    this.workKey = '',
    this.coverId = '',
    this.isAvailable = false,
    this.isFullTextAvailable = false,
    this.accessType = BookAccessType.none,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: JsonParser.parseString(json['key']).split('/').last,
      title: JsonParser.parseString(json['title']),
      authors: JsonParser.parseList<String>(json['author_name']),
      workKey: JsonParser.parseString(json['key']),
      coverId: JsonParser.parseString(json['cover_i']),
      isAvailable: JsonParser.parseBool(json['public_scan_b']),
      isFullTextAvailable: JsonParser.parseBool(json['has_fulltext']),
      accessType: setAccessType(JsonParser.parseString(json['ebook_access'])),
    );
  }

  String get coverImageUrl => coverId.isNotEmpty
      ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
      : 'https://via.placeholder.com/150';

  String get workUrl => 'https://openlibrary.org$workKey';
}

BookAccessType setAccessType(String access) {
  if (access == 'public') {
    return BookAccessType.public;
  } else if (access == 'borrowable') {
    return BookAccessType.borrowable;
  }
  return BookAccessType.none;
}

class BookListingModel {
  final List<BookModel> books;
  final PaginationModel pagination;

  BookListingModel({required this.books, required this.pagination});
  BookListingModel.empty()
    : this(books: [], pagination: PaginationModel.empty());
}

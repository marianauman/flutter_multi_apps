import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/text_constants.dart';
import '../../../../core/models/pagination_model.dart';
import '../../../../shared/helpers/json_parser.dart';

class BookModel {
  final String id;
  final String title;
  final List<String> authors;
  final String workKey;
  final String coverId;
  final bool isScannedAvailable;
  final bool isFullTextAvailable;
  final BookAccessType accessType;
  final String lendingIdentifier;
  final BookStatus status;

  BookModel({
    this.id = '',
    this.title = '',
    this.authors = const [],
    this.workKey = '',
    this.coverId = '',
    this.isScannedAvailable = false,
    this.isFullTextAvailable = false,
    this.accessType = BookAccessType.none,
    this.lendingIdentifier = '',
    this.status = BookStatus.none,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    // Check if this is API data (has 'key' field) or stored data (has 'id' field)
    if (json.containsKey('key')) {
      // API data format
      return BookModel(
        id: JsonParser.parseString(json['key']).split('/').last,
        title: JsonParser.parseString(json['title']),
        authors: JsonParser.parseList<String>(json['author_name']),
        workKey: JsonParser.parseString(json['key']),
        coverId: JsonParser.parseString(json['cover_i']),
        isScannedAvailable: JsonParser.parseBool(json['public_scan_b']),
        isFullTextAvailable: JsonParser.parseBool(json['has_fulltext']),
        lendingIdentifier: JsonParser.parseString(json['lending_identifier_s']),
        accessType: setAccessType(JsonParser.parseString(json['ebook_access'])),
      );
    } else {
      // Stored data format
      return BookModel(
        id: JsonParser.parseString(json['id']),
        title: JsonParser.parseString(json['title']),
        authors: List<String>.from(json['authors'] ?? []),
        workKey: JsonParser.parseString(json['workKey']),
        coverId: JsonParser.parseString(json['coverId']),
        isScannedAvailable: JsonParser.parseBool(json['isScannedAvailable']),
        lendingIdentifier: JsonParser.parseString(json['lendingIdentifier']),
        isFullTextAvailable: JsonParser.parseBool(json['isFullTextAvailable']),
        accessType: BookAccessType.values[json['accessType'] ?? 0],
        status: BookStatus.values[json['status'] ?? 0],
      );
    }
  }

  String get coverImageUrl => coverId.isNotEmpty
      ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
      : 'https://via.placeholder.com/150';

  String get workUrl => 'https://openlibrary.org$workKey';

  String get bookUrl =>
      'https://archive.org/details/$lendingIdentifier/mode/2up';

  bool get isReadable =>
      isFullTextAvailable &&
      accessType == BookAccessType.public &&
      lendingIdentifier.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors,
      'workKey': workKey,
      'coverId': coverId,
      'isScannedAvailable': isScannedAvailable,
      'lendingIdentifier': lendingIdentifier,
      'isFullTextAvailable': isFullTextAvailable,
      'accessType': accessType.index,
      'status': status.index,
    };
  }

  BookModel copyWith({required BookStatus updatedStatus}) {
    return BookModel(
      id: id,
      title: title,
      authors: authors,
      workKey: workKey,
      coverId: coverId,
      isScannedAvailable: isScannedAvailable,
      lendingIdentifier: lendingIdentifier,
      isFullTextAvailable: isFullTextAvailable,
      accessType: accessType,
      status: updatedStatus,
    );
  }
}

BookAccessType setAccessType(String access) {
  if (access == 'public') {
    return BookAccessType.public;
  } else if (access == 'borrowable') {
    return BookAccessType.borrowable;
  }
  return BookAccessType.none;
}

String getBookStatusText(BookStatus status) {
  switch (status) {
    case BookStatus.wantToRead:
      return TextConstants.wantToRead;
    case BookStatus.reading:
      return TextConstants.reading;
    case BookStatus.finished:
      return TextConstants.finished;
    default:
      return '';
  }
}

String getBookActionTextUsingStatus(BookStatus status) {
  switch (status) {
    case BookStatus.wantToRead:
      return TextConstants.start;
    case BookStatus.reading:
      return TextConstants.finish;
    case BookStatus.finished:
      return TextConstants.start;
    default:
      return TextConstants.wantToRead;
  }
}

BookStatus getBookNextStatus(BookStatus status) {
  switch (status) {
    case BookStatus.none:
      return BookStatus.wantToRead;
    case BookStatus.wantToRead:
      return BookStatus.reading;
    case BookStatus.reading:
      return BookStatus.finished;
    case BookStatus.finished:
      return BookStatus.reading;
  }
}

class BookListingModel {
  final List<BookModel> books;
  final PaginationModel pagination;

  BookListingModel({required this.books, required this.pagination});
  BookListingModel.empty()
    : this(books: [], pagination: PaginationModel.empty());
}

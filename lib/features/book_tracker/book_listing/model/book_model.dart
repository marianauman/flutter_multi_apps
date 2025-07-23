import '../../../../shared/helpers/json_parser.dart';

class BookModel {
  final String id;
  final String title;
  final List<String> authors;
  final String workKey;
  final String coverId;
  final bool isAvailable;

  BookModel({
    required this.id,
    required this.title,
    required this.authors,
    required this.workKey,
    required this.coverId,
    required this.isAvailable,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: JsonParser.parseString(json['key']).split('/').last,
      title: JsonParser.parseString(json['title']),
      authors: JsonParser.parseList<String>(json['author_name']),
      workKey: JsonParser.parseString(json['key']),
      coverId: JsonParser.parseString(json['cover_i']),
      isAvailable: JsonParser.parseBool(json['public_scan_b']),
    );
  }

  String get coverImageUrl => coverId.isNotEmpty
      ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
      : 'https://via.placeholder.com/150';

  String get workUrl => 'https://openlibrary.org$workKey';

}
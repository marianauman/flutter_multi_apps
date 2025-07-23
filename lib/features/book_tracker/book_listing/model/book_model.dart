class BookModel {
  final String id;
  final String title;
  final List<String> authors;
  final String workKey;
  final int? coverId;
  final bool isReadable;

  BookModel({
    required this.id,
    required this.title,
    required this.authors,
    required this.workKey,
    required this.coverId,
    required this.isReadable,
  });

  // factory BookModel.fromJson(Map<String, dynamic> json) {
  //   return BookModel(
  //     id: json['id'] ?? '',
  //     title: json['title'] ?? 'Untitled',
  //     authors: List<String>.from(json['author_name'] ?? []),
  //     workKey: json['key'] ?? '',
  //     coverId: json['cover_i'],
  //     isReadable: json['availability']?['is_readable'] ?? false,
  //   );
  // }

  // String get coverImageUrl => coverId != null
  //     ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
  //     : 'https://via.placeholder.com/150';

  // String get workUrl => 'https://openlibrary.org$workKey';

}
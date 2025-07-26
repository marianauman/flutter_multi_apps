import '../model/book_model.dart';

class BookListingState {
  final BookListingModel booksListing;
  final String query;
  final bool isLoading;
  final bool isMoreLoading;

  BookListingState({
    required this.booksListing,
    required this.query,
    required this.isLoading,
    required this.isMoreLoading,
  });

  BookListingState copyWith({
    BookListingModel? booksListing,
    String? query,
    bool? isLoading,
    bool? isMoreLoading,
  }) {
    return BookListingState(
      booksListing: booksListing ?? this.booksListing,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
    );
  }
}

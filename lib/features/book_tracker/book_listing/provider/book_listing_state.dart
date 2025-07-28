import '../model/book_model.dart';

class BookListingState {
  final BookListingModel booksListing;
  final String query;
  final bool isLoading;
  final bool isMoreLoading;
  final Map<String, dynamic> bookAppliedFiltersData;

  BookListingState({
    required this.booksListing,
    required this.query,
    required this.isLoading,
    required this.isMoreLoading,
    required this.bookAppliedFiltersData,
  });

  BookListingState copyWith({
    BookListingModel? booksListing,
    String? query,
    bool? isLoading,
    bool? isMoreLoading,
    Map<String, dynamic>? bookAppliedFiltersData,
  }) {
    return BookListingState(
      booksListing: booksListing ?? this.booksListing,
      bookAppliedFiltersData:
          bookAppliedFiltersData ?? this.bookAppliedFiltersData,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
    );
  }
}

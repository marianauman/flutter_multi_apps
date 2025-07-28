import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/no_internet_dialog.dart';
import '../model/book_model.dart';
import 'book_listing_service.dart';
import 'book_listing_state.dart';

class BookListingProvider extends StateNotifier<BookListingState> {
  BookListingProvider(this._bookService)
    : super(
        BookListingState(
          booksListing: BookListingModel.empty(),
          bookAppliedFiltersData: {},
          query: '',
          isLoading: false,
          isMoreLoading: false,
        ),
      );

  final BookListingService _bookService;

  String getQueryString() {
    if (state.bookAppliedFiltersData.isNotEmpty) {
      String title = state.bookAppliedFiltersData['title'] ?? '';
      String author = state.bookAppliedFiltersData['author'] ?? '';
      bool isReadable = state.bookAppliedFiltersData['is_readable'] ?? false;
      String queryString = '';
      if (title.isNotEmpty) {
        queryString += '&title=$title';
      }
      if (author.isNotEmpty) {
        queryString += '&author=$author';
      }
      if (isReadable) {
        queryString += '&isReadable=$isReadable';
      }
      return queryString.trim().isEmpty ? '&q=fiction' : queryString;
    }
    return '&q=fiction';
  }

  Future<void> fetchBookListing({int page = 1}) async {
    if (page == 1) {
      state = state.copyWith(isLoading: true);
    } else {
      state = state.copyWith(isMoreLoading: true);
    }
    try {
      String queryString = getQueryString();
      final model = await _bookService.fetchBookListing(
        queryString: queryString,
        page: page,
      );
      if (model == null) return;
      state = state.copyWith(
        booksListing: BookListingModel(
          books: page == 1
              ? model.books
              : [...state.booksListing.books, ...model.books],
          pagination: model.pagination,
        ),
        isLoading: false,
        isMoreLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        booksListing: BookListingModel.empty(),
        isLoading: false,
        isMoreLoading: false,
      );
      if (e is DioApiError) {
        if (e == DioApiError.noInternet || e == DioApiError.timeout) {
          showNoInternetDialog(() {
            fetchBookListing(page: page);
          });
        }
      }
    }
  }

  void handleScroll(ScrollPosition position) {
    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;
    final scrollThreshold = maxScroll;
    if (currentScroll >= scrollThreshold &&
        !state.isLoading &&
        !state.isMoreLoading &&
        state.booksListing.pagination.currentPage <
            state.booksListing.pagination.lastPage) {
      int nextPage = state.booksListing.pagination.currentPage + 1;
      fetchBookListing(page: nextPage);
    }
  }

  void handleBookAction(BookModel book) {
    final updatedBook = book.copyWith(
      updatedStatus: getBookNextStatus(book.status),
    );
    if (book.status == BookStatus.none) {
      _bookService.saveBookToMyBooks(updatedBook);
    } else {
      _bookService.updateBookStatus(book.id, updatedBook.status);
    }
    state = state.copyWith(
      booksListing: BookListingModel(
        pagination: state.booksListing.pagination,
        books: state.booksListing.books
            .map((e) => e.id == book.id ? updatedBook : e)
            .toList(),
      ),
    );
  }

  Future<void> refreshBookStatuses() async {
    try {
      final updatedBooks = await _bookService.refreshBookStatuses(
        state.booksListing.books,
      );
      state = state.copyWith(
        booksListing: BookListingModel(
          books: updatedBooks,
          pagination: state.booksListing.pagination,
        ),
      );
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> applyFilter(Map<String, dynamic> filters) async {
    state = state.copyWith(bookAppliedFiltersData: filters);
    await fetchBookListing(page: 1);
  }

  Future<void> clearFilters() async {
    if (state.bookAppliedFiltersData.isNotEmpty) {
      state = state.copyWith(bookAppliedFiltersData: {});
      await fetchBookListing(page: 1);
    }
  }
}

final bookListingProvider =
    StateNotifierProvider.autoDispose<BookListingProvider, BookListingState>((
      ref,
    ) {
      return BookListingProvider(BookListingService());
    });

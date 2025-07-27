import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../book_listing/model/book_model.dart';
import 'book_listing_service.dart';
import 'book_listing_state.dart';
import '../../../../core/constants/app_constants.dart';

class MyBooksProvider extends StateNotifier<MyBooksState> {
  MyBooksProvider(this._bookService)
    : super(
        MyBooksState(
          allBooks: const [],
          wantToReadBooks: const [],
          readingBooks: const [],
          finishedBooks: const [],
          selectedTab: BookStatus.none,
          isLoading: false,
        ),
      );

  final MyBooksService _bookService;

  Future<void> fetchMyBooks() async {
    state = state.copyWith(isLoading: true);
    try {
      final model = await _bookService.fetchMyBookListing();
      if (model != null) {
        final allBooks = model;
        final wantToReadBooks = allBooks
            .where((book) => book.status == BookStatus.wantToRead)
            .toList();
        final readingBooks = allBooks
            .where((book) => book.status == BookStatus.reading)
            .toList();
        final finishedBooks = allBooks
            .where((book) => book.status == BookStatus.finished)
            .toList();

        state = state.copyWith(
          allBooks: allBooks,
          wantToReadBooks: wantToReadBooks,
          readingBooks: readingBooks,
          finishedBooks: finishedBooks,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void selectTab(BookStatus tab) {
    state = state.copyWith(selectedTab: tab);
  }

  Future<void> updateBookStatus(String bookId, BookStatus status) async {
    var newStatus = getBookNextStatus(status);
    try {
      await _bookService.updateBookStatus(bookId, newStatus);
      await fetchMyBooks();
    } catch (e) {
      // Handle error
    }
  }
}

final myBooksProvider =
    StateNotifierProvider.autoDispose<MyBooksProvider, MyBooksState>((
      ref,
    ) {
      return MyBooksProvider(MyBooksService());
    });

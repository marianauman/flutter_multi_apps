import '../../book_listing/model/book_model.dart';
import '../../../../core/constants/app_constants.dart';

class MyBooksState {
  final List<BookModel> allBooks;
  final List<BookModel> wantToReadBooks;
  final List<BookModel> readingBooks;
  final List<BookModel> finishedBooks;
  final BookStatus selectedTab;
  final bool isLoading;

  MyBooksState({
    required this.allBooks,
    required this.wantToReadBooks,
    required this.readingBooks,
    required this.finishedBooks,
    this.selectedTab = BookStatus.none,
    required this.isLoading,
  });

  MyBooksState copyWith({
    List<BookModel>? allBooks,
    List<BookModel>? wantToReadBooks,
    List<BookModel>? readingBooks,
    List<BookModel>? finishedBooks,
    BookStatus? selectedTab,
    bool? isLoading,
  }) {
    return MyBooksState(
      allBooks: allBooks ?? this.allBooks,
      wantToReadBooks: wantToReadBooks ?? this.wantToReadBooks,
      readingBooks: readingBooks ?? this.readingBooks,
      finishedBooks: finishedBooks ?? this.finishedBooks,
      selectedTab: selectedTab ?? this.selectedTab,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  List<BookModel> get currentTabBooks {
    switch (selectedTab) {
      case BookStatus.none:
        return allBooks;
      case BookStatus.wantToRead:
        return wantToReadBooks;
      case BookStatus.reading:
        return readingBooks;
      case BookStatus.finished:
        return finishedBooks;
    }
  }

  int get allBooksCount => allBooks.length;
  int get wantToReadCount => wantToReadBooks.length;
  int get readingCount => readingBooks.length;
  int get finishedCount => finishedBooks.length;
}

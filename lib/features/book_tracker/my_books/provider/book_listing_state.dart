import '../../book_listing/model/book_model.dart';

class MyBooksState {
  final List<BookModel> myBooks;
  final bool isLoading;

  MyBooksState({
    required this.myBooks,
    required this.isLoading,
  });

  MyBooksState copyWith({
    List<BookModel>? myBooks,
    bool? isLoading,
  }) {
    return MyBooksState(
      myBooks: myBooks ?? this.myBooks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

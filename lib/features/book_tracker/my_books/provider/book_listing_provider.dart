import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'book_listing_service.dart';
import 'book_listing_state.dart';

class MyBooksProvider extends StateNotifier<MyBooksState> {
  MyBooksProvider(this._bookService)
    : super(
        MyBooksState(
          myBooks: const[],
          isLoading: false,
        ),
      );

  final MyBooksService _bookService;

  // Future<void> fetchMyBooks() async {
  //   state = state.copyWith(isLoading: true);
  //   try {
  //     final model = await _bookService.fetchMyBookListing();
      
  //   } catch (e) {
      
  //   }
  // } 
}

final myBooksProvider =
    StateNotifierProvider.autoDispose<MyBooksProvider, MyBooksState>((
      ref,
    ) {
      return MyBooksProvider(MyBooksService());
    });

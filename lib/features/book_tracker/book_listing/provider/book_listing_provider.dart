// class DiscoverViewModel extends StateNotifier<AsyncValue<List<Book>>> {
//   DiscoverViewModel(this._bookService) : super(const AsyncLoading()) {
//     loadBooks();
//   }

//   final BookService _bookService;

//   Future<void> loadBooks() async {
//     try {
//       final books = await _bookService.fetchBooks();
//       state = AsyncData(books);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }
// }

// //////////////
// ///
// ///
// ///
// ///
// final discoverViewModelProvider = StateNotifierProvider<DiscoverViewModel, AsyncValue<List<Book>>>(
//   (ref) => DiscoverViewModel(ref.watch(bookServiceProvider)),
// );

// /////////////////
// ///
// ///
// ///
// ///
// ///
// import 'package:dio/dio.dart';
// import '../model/book.dart'; // path depends on your structure

// class BookService {
//   final Dio _dio;

//   BookService(this._dio);

//   Future<List<Book>> fetchBooks({String query = "fiction"}) async {
//     final response = await _dio.get(
//       'https://openlibrary.org/search.json',
//       queryParameters: {
//         'q': query,
//       },
//     );

//     final docs = response.data['docs'] as List;
//     return docs.map((json) => Book.fromJson(json)).toList();
//   }
// }

// ////////////////
// ///
// ///
// ///
// ///
// ///
// final dioProvider = Provider<Dio>((ref) => Dio());

// final bookServiceProvider = Provider<BookService>((ref) {
//   return BookService(ref.watch(dioProvider));
// });


// /////////////////////
// ///
// ///
// ///
// ///
// ///
// final discoverViewModelProvider =
//     StateNotifierProvider<DiscoverViewModel, AsyncValue<List<Book>>>(
//   (ref) => DiscoverViewModel(ref.watch(bookServiceProvider)),
// );


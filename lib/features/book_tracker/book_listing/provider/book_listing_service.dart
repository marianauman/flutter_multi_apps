import 'package:flutter_multi_apps/features/book_tracker/book_listing/model/book_model.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/managers/api_managers.dart';
import '../../../../core/models/pagination_model.dart';
import '../storage/book_storage_service.dart';

class BookListingService {

  final BookStorageService _storageService = BookStorageService.db;

  Future<BookListingModel?> fetchBookListing({String query = 'fiction', int page = 1}) async {
    String endpoint = "${ApiConstants.bookListing}?q=$query&page=$page";
    final response = await ApiManager(endpoint: endpoint).getApi();

    if(response['docs'] is List) {
      List docs = response['docs'];
      List<BookModel> books = docs.map((json) => BookModel.fromJson(json)).toList();
      
      // Check Hive storage and update book statuses
      List<BookModel> updatedBooks = await _updateBooksWithHiveStatus(books);
      
      PaginationModel pagination = PaginationModel.fromJson(total: response['num_found'], currentPage: page, perPage: 100);
      return BookListingModel(books: updatedBooks, pagination: pagination);
    }
    return null;
  }

  Future<List<BookModel>> _updateBooksWithHiveStatus(
    List<BookModel> books,
  ) async {
    try {
      final myBooks = await _storageService.getAllMyBooks();

      final Map<String, BookStatus> bookStatusMap = {};
      for (final book in myBooks) {
        bookStatusMap[book.id] = book.status;
      }

      return books.map((book) {
        final hiveStatus = bookStatusMap[book.id];
        if (hiveStatus != null) {
          return book.copyWith(updatedStatus: hiveStatus);
        }
        return book.copyWith(updatedStatus: BookStatus.none);
      }).toList();
    } catch (e) {
      return books;
    }
  }

  Future<void> saveBookToMyBooks(BookModel book) async {
    try {
      await _storageService.saveBookToMyBooks(book, BookStatus.wantToRead);
    } catch (e) {
      throw Exception('Failed to save book to my books: $e');
    }
  }

  Future<void> updateBookStatus(String bookId, BookStatus newStatus) async {
    try {
      await _storageService.updateBookStatus(bookId, newStatus);
    } catch (e) {
      throw Exception('Failed to update book status: $e');
    }
  }

  // Refresh book statuses from Hive storage for existing books
  Future<List<BookModel>> refreshBookStatuses(List<BookModel> books) async {
    return await _updateBooksWithHiveStatus(books);
  }
}
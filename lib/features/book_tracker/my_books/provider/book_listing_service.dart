import 'package:flutter_multi_apps/features/book_tracker/book_listing/model/book_model.dart';
import 'package:flutter_multi_apps/features/book_tracker/book_listing/storage/book_storage_service.dart';
import '../../../../core/constants/app_constants.dart';

class MyBooksService {
  final BookStorageService _storageService = BookStorageService.db;

  Future<List<BookModel>?> fetchMyBookListing() async {
    try {
      final allBooks = await _storageService.getAllMyBooks();
      return allBooks;
    } catch (e) {
      throw Exception('Failed to fetch my books: $e');
    }
  }

  Future<List<BookModel>> getBooksByStatus(BookStatus status) async {
    try {
      return await _storageService.getBooksByStatus(status);
    } catch (e) {
      throw Exception('Failed to get books by status: $e');
    }
  }

  Future<void> updateBookStatus(String bookId, BookStatus newStatus) async {
    try {
      await _storageService.updateBookStatus(bookId, newStatus);
    } catch (e) {
      throw Exception('Failed to update book status: $e');
    }
  }

  Future<void> removeBook(String bookId) async {
    try {
      await _storageService.removeBookFromMyBooks(bookId);
    } catch (e) {
      throw Exception('Failed to remove book: $e');
    }
  }
}
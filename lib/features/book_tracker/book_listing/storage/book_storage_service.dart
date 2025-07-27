import 'package:flutter_multi_apps/core/constants/hive_constants.dart';
import 'package:flutter_multi_apps/core/shared_instances.dart/hive_box_shared_instance.dart';
import '../model/book_model.dart';
import '../../../../core/constants/app_constants.dart';

class BookStorageService {
  BookStorageService._();
  static final BookStorageService db = BookStorageService._();
  final HiveBoxSharedInstance _hiveManager = HiveBoxSharedInstance();
  final _boxName = HiveConstants.myBooksBox;

  // Save book to my books list with specified status
  Future<void> saveBookToMyBooks(BookModel book, BookStatus status) async {
    try {
      // Create a book with specified status
      final bookToSave = BookModel(
        id: book.id,
        title: book.title,
        authors: book.authors,
        workKey: book.workKey,
        coverId: book.coverId,
        isScannedAvailable: book.isScannedAvailable,
        lendingIdentifier: book.lendingIdentifier,
        isFullTextAvailable: book.isFullTextAvailable,
        accessType: book.accessType,
        status: status,
      );

      // Save to myBooksBox with book ID as key
      await _hiveManager.putData(
        boxName: _boxName,
        key: book.id,
        value: bookToSave.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to save book: $e');
    }
  }

  // Get all books from my books list
  Future<List<BookModel>> getAllMyBooks() async {
    try {
      final box = _hiveManager.getBox(_boxName);
      final List<BookModel> books = [];

      for (var key in box.keys) {
        final bookData = box.get(key);
        if (bookData != null) {
          final book = BookModel.fromJson(Map<String, dynamic>.from(bookData));
          books.add(book);
        }
      }

      return books;
    } catch (e) {
      throw Exception('Failed to get all my books: $e');
    }
  }

  // Update book status
  Future<void> updateBookStatus(String bookId, BookStatus newStatus) async {
    try {
      final bookData = await _hiveManager.getData(
        boxName: _boxName,
        key: bookId,
      );

      if (bookData != null) {
        final book = BookModel.fromJson(Map<String, dynamic>.from(bookData));
        final updatedBook = BookModel(
          id: book.id,
          title: book.title,
          authors: book.authors,
          workKey: book.workKey,
          coverId: book.coverId,
          isScannedAvailable: book.isScannedAvailable,
          lendingIdentifier: book.lendingIdentifier,
          isFullTextAvailable: book.isFullTextAvailable,
          accessType: book.accessType,
          status: newStatus,
        );

        await _hiveManager.putData(
          boxName: _boxName,
          key: bookId,
          value: updatedBook.toJson(),
        );
      }
    } catch (e) {
      throw Exception('Failed to update book status: $e');
    }
  }
}

import 'package:flutter_multi_apps/core/constants/hive_constants.dart';
import 'package:flutter_multi_apps/core/shared_instances.dart/hive_box_shared_instance.dart';
import '../model/book_model.dart';
import '../../../../core/constants/app_constants.dart';

class BookStorageService {
  BookStorageService._();
  static final BookStorageService db = BookStorageService._();
  final HiveBoxSharedInstance _hiveManager = HiveBoxSharedInstance();
  final _boxName = HiveConstants.myBooksBox;

  // Save book to "Want to Read" list
  Future<void> saveBookToWantToRead(BookModel book) async {
    try {
      // Create a book with "Want to Read" status
      final bookToSave = BookModel(
        id: book.id,
        title: book.title,
        authors: book.authors,
        workKey: book.workKey,
        coverId: book.coverId,
        isAvailable: book.isAvailable,
        isFullTextAvailable: book.isFullTextAvailable,
        accessType: book.accessType,
        status: BookStatus.wantToRead,
        isFavourite: book.isFavourite,
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

  // Get all books from "Want to Read" list
  Future<List<BookModel>> getWantToReadBooks() async {
    try {
      final box = _hiveManager.getBox(_boxName);
      final List<BookModel> books = [];

      for (var key in box.keys) {
        final bookData = box.get(key);
        if (bookData != null) {
          final book = BookModel.fromJson(Map<String, dynamic>.from(bookData));
          if (book.status == BookStatus.wantToRead) {
            books.add(book);
          }
        }
      }

      return books;
    } catch (e) {
      throw Exception('Failed to get want to read books: $e');
    }
  }

  // Check if book is in "Want to Read" list
  Future<bool> isBookInWantToRead(String bookId) async {
    try {
      return await _hiveManager.containsKey(
        boxName: _boxName,
        key: bookId,
      );
    } catch (e) {
      return false;
    }
  }

  // Remove book from "Want to Read" list
  Future<void> removeBookFromWantToRead(String bookId) async {
    try {
      await _hiveManager.deleteData(
        boxName: _boxName,
        key: bookId,
      );
    } catch (e) {
      throw Exception('Failed to remove book: $e');
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
          isAvailable: book.isAvailable,
          isFullTextAvailable: book.isFullTextAvailable,
          accessType: book.accessType,
          status: newStatus,
          isFavourite: book.isFavourite,
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

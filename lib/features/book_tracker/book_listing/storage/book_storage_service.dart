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
        isAvailable: book.isAvailable,
        isFullTextAvailable: book.isFullTextAvailable,
        accessType: book.accessType,
        status: status,
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

  // Save book to "Want to Read" list (for backward compatibility)
  Future<void> saveBookToWantToRead(BookModel book) async {
    await saveBookToMyBooks(book, BookStatus.wantToRead);
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

  // Get books by status
  Future<List<BookModel>> getBooksByStatus(BookStatus status) async {
    try {
      final allBooks = await getAllMyBooks();
      return allBooks.where((book) => book.status == status).toList();
    } catch (e) {
      throw Exception('Failed to get books by status: $e');
    }
  }

  // Get all books from "Want to Read" list (for backward compatibility)
  Future<List<BookModel>> getWantToReadBooks() async {
    return getBooksByStatus(BookStatus.wantToRead);
  }

  // Get reading books
  Future<List<BookModel>> getReadingBooks() async {
    return getBooksByStatus(BookStatus.reading);
  }

  // Get finished books
  Future<List<BookModel>> getFinishedBooks() async {
    return getBooksByStatus(BookStatus.finished);
  }

  // Check if book is in my books list
  Future<bool> isBookInMyBooks(String bookId) async {
    try {
      return await _hiveManager.containsKey(
        boxName: _boxName,
        key: bookId,
      );
    } catch (e) {
      return false;
    }
  }

  // Check if book is in "Want to Read" list (for backward compatibility)
  Future<bool> isBookInWantToRead(String bookId) async {
    return isBookInMyBooks(bookId);
  }

  // Remove book from my books list
  Future<void> removeBookFromMyBooks(String bookId) async {
    try {
      await _hiveManager.deleteData(
        boxName: _boxName,
        key: bookId,
      );
    } catch (e) {
      throw Exception('Failed to remove book: $e');
    }
  }

  // Remove book from "Want to Read" list (for backward compatibility)
  Future<void> removeBookFromWantToRead(String bookId) async {
    await removeBookFromMyBooks(bookId);
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

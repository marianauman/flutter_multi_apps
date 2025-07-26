import 'package:flutter_multi_apps/features/book_tracker/book_listing/model/book_model.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/managers/api_managers.dart';
import '../../../../core/models/pagination_model.dart';

class BookListingService {

  Future<BookListingModel?> fetchBookListing({String query = 'fiction', int page = 1}) async {
    String endpoint = "${ApiConstants.bookListing}?q=$query&page=$page";
    final response = await ApiManager(endpoint: endpoint).getApi();

    if(response['docs'] is List) {
      List docs = response['docs'];
      List<BookModel> books = docs.map((json) => BookModel.fromJson(json)).toList();
      PaginationModel pagination = PaginationModel.fromJson(total: response['num_found'], currentPage: page, perPage: 100);
      return BookListingModel(books: books, pagination: pagination);
    }
    return null;
  }
}
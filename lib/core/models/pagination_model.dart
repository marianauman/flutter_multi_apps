import '../../shared/helpers/json_parser.dart';

class PaginationModel {
  final int total;
  final int currentPage;
  final int perPage;
  final int lastPage;

  PaginationModel({
    required this.total,
    required this.currentPage,
    required this.perPage,
    required this.lastPage,
  });
  PaginationModel.empty() : this(total: 0, currentPage: 0, perPage: 0, lastPage: 0);

  factory PaginationModel.fromJson({
    required dynamic total,
    required dynamic currentPage,
    required dynamic perPage,
  }) {
    return PaginationModel(
      total: JsonParser.parseInt(total),
      currentPage: JsonParser.parseInt(currentPage),
      perPage: JsonParser.parseInt(perPage),
      lastPage: getLastPage(JsonParser.parseInt(total), JsonParser.parseInt(perPage)),
    );
  }
}

int getLastPage(int total, int perPage) {
  return (total / perPage).ceil();
}

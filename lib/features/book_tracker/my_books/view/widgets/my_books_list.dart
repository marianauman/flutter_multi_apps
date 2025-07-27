import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/features/book_tracker/book_listing/view/widgets/book_listing_skeleton.dart';
import 'package:flutter_multi_apps/shared/widgets/empty_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../book_listing/view/widgets/book_listing_list_cell.dart';
import '../../provider/book_listing_provider.dart';

class MyBooksList extends ConsumerStatefulWidget {
  const MyBooksList({super.key});
  @override
  ConsumerState<MyBooksList> createState() => _MyBooksListState();
}

class _MyBooksListState extends ConsumerState<MyBooksList> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myBooksProvider);
    if (state.isLoading) {
      return const BookListingSkeleton();
    }
    if (state.currentTabBooks.isEmpty) {
      return Center(child: SingleChildScrollView(child: const EmptyStateView()));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.currentTabBooks.length,
      itemBuilder: (context, index) {
        final book = state.currentTabBooks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BookListingListCell(book: book, isMyBooks: true),
        );
      },
    );
  }
}

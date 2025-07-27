import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_multi_apps/core/constants/text_constants.dart';
import 'package:flutter_multi_apps/shared/widgets/base_screen.dart';
import 'widgets/my_books_list.dart';
import 'widgets/my_books_tabs.dart';
import 'widgets/my_books_top_image.dart';
import '../provider/book_listing_provider.dart';

class MyBooksScreen extends ConsumerStatefulWidget {
  const MyBooksScreen({super.key});
  @override
  ConsumerState<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends ConsumerState<MyBooksScreen> {
  @override
  void initState() {
    _fetchMyBooks();
    super.initState();
  }

  void _fetchMyBooks() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myBooksProvider.notifier).fetchMyBooks();
    });
  }

  @override
  Widget build(BuildContext context) {

    return BaseScreen(
      title: TextConstants.myBooks,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [const MyBooksTopImage()];
        },
        body: Stack(
          children: [
            Column(
              children: [
                const MyBooksTabs(),
                Expanded(child: const MyBooksList()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

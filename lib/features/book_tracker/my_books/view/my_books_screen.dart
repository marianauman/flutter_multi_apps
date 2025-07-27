import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/shared/widgets/base_screen.dart';
import 'widgets/my_books_tabs.dart';
import 'widgets/my_books_top_image.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});
  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  // Mock data for books list
  // final List<BookModel> _myBooks = [
  //   BookModel(
  //     id: '1',
  //     title: 'The Great Gatsby',
  //     authors: ['F. Scott Fitzgerald'],
  //     coverId: '890',
  //     status: BookStatus.reading,
  //   ),
  //   BookModel(
  //     id: '2',
  //     title: 'To Kill a Mockingbird',
  //     authors: ['Harper Lee'],
  //     coverId: '890',
  //     status: BookStatus.wantToRead,
  //   ),
  //   BookModel(
  //     id: '3',
  //     title: '1984',
  //     authors: ['George Orwell'],
  //     coverId: '890',
  //     status: BookStatus.finished,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showAppBar: false,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [const MyBooksTopImage()];
        },
        body: Column(children: [const MyBooksTabs()]),
      ),
    );
  }

  // Widget _buildBooksList() {
  //   return ListView.separated(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: _myBooks.length,
  //     separatorBuilder: (context, index) => 15.customVerticalSpace,
  //     itemBuilder: (context, index) {
  //       return BookListingListCell(book: _myBooks[index]);
  //     },
  //   );
  // }
}

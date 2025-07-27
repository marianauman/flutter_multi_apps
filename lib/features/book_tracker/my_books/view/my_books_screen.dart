import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/constants/text_constants.dart';
import 'package:flutter_multi_apps/shared/widgets/base_screen.dart';
import 'widgets/my_books_tabs.dart';
import 'widgets/my_books_top_image.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});
  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: TextConstants.myBooks,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [const MyBooksTopImage()];
        },
        body: Column(
          children: [
            MyBooksTabs(
              onTabSelected: (status) {
                print(status);
              },
            ),
          ],
        ),
      ),
    );
  }
}

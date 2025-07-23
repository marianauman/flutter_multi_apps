import 'package:flutter/material.dart';
import '../../../../shared/widgets/base_screen.dart';

class BookListingScreenTab extends StatefulWidget {
  const BookListingScreenTab({super.key});
  @override
  State<BookListingScreenTab> createState() => _BookListingScreenTabState();
}

class _BookListingScreenTabState extends State<BookListingScreenTab> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(child: Column(children: [Container()]));
  }
}
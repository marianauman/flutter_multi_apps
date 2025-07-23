import 'package:flutter/material.dart';
import '../../../../shared/widgets/base_screen.dart';

class BookListingScreen extends StatefulWidget {
  const BookListingScreen({super.key});

  @override
  State<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends State<BookListingScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(child: Column(children: [Container()]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/base_screen.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_icon_button.dart';

class BookListingScreen extends StatefulWidget {
  const BookListingScreen({super.key});

  @override
  State<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends State<BookListingScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          CustomIconButton(
            onPressed: () {},
            icon: Icons.add,
            borderRadius: 10.r,
            isLoading: true,
          ),
        ],
      ),
    );
  }
}

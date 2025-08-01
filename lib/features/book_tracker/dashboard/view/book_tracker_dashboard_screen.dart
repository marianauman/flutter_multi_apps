import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/theme.dart';
import '../../../../core/constants/text_constants.dart';
import '../../../../shared/widgets/base_screen.dart';
import '../../book_listing/provider/book_listing_provider.dart';
import '../../book_listing/view/book_listing_screen.dart';
import '../../my_books/provider/book_listing_provider.dart';
import '../../my_books/view/my_books_screen.dart';
import '../../settings_tab/view/menu_screen.dart';

class BookTrackerDashboardScreen extends ConsumerStatefulWidget {
  const BookTrackerDashboardScreen({super.key});

  @override
  ConsumerState<BookTrackerDashboardScreen> createState() =>
      _BookTrackerDashboardScreenState();
}

class _BookTrackerDashboardScreenState
    extends ConsumerState<BookTrackerDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const MyBooksScreen(),
    const BookListingScreen(),
    const MenuScreen(),
  ];

  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.book),
      label: TextConstants.myBooks,
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      label: TextConstants.discover,
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.line_horizontal_3),
      label: TextConstants.menu,
    ),
  ];

  Widget _bottomNavigationBar() {
    final tabCount = 3;
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / tabCount;
    return Stack(
      children: [
        BottomNavigationBar(
          items: _items,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 0) {
              ref.read(myBooksProvider.notifier).fetchMyBooks();
            } else if (index == 1) {
              ref.read(bookListingProvider.notifier).refreshBookStatuses();
            }
          },
        ),
        Positioned(
          top: 0,
          left: _currentIndex * tabWidth,
          child: Container(
            width: tabWidth,
            height: 3,
            color: AppColors().primary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showAppBar: false,
      bottomNavigationBar: _bottomNavigationBar(),
      child: IndexedStack(index: _currentIndex, children: _pages),
    );
  }
}

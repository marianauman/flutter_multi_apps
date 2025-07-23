import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../config/text_styles.dart';
import '../../../../config/theme.dart';
import '../../../../core/constants/text_constants.dart';
import '../../../../shared/widgets/base_screen.dart';
import '../../book_listing/view/book_listing_screen.dart';

class BookTrackerDashboardScreen extends StatefulWidget {
  const BookTrackerDashboardScreen({super.key});

  @override
  State<BookTrackerDashboardScreen> createState() =>
      _BookTrackerDashboardScreenState();
}

class _BookTrackerDashboardScreenState
    extends State<BookTrackerDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: AppText.body1(text: 'Home')),
    const BookListingScreen(),
    Center(child: AppText.body1(text: 'Settings')),
  ];

  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.house_fill),
      label: TextConstants.home,
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

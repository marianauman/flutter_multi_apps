import 'package:flutter/material.dart';
import '../../../../config/text_styles.dart';
import '../../../../config/theme.dart';
import '../../../../shared/widgets/base_screen.dart';
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
    Center(child: AppText.body1(text: 'Discover')),
    Center(child: AppText.body1(text: 'Settings')),
  ];

  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
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
      child: _pages[_currentIndex],
    );
  }
}

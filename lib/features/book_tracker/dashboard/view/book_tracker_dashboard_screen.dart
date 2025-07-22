import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/config/text_styles.dart';
import 'package:flutter_multi_apps/shared/widgets/base_screen.dart';

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

  final List<NavigationDestination> _destinations = [
    NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.explore), label: 'Discover'),
    NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  Widget _bottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      destinations: _destinations,
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

import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/config/text_styles.dart';
import 'package:flutter_multi_apps/shared/widgets/base_screen.dart';

class BookTrackerDashboardScreenTab extends StatefulWidget {
  const BookTrackerDashboardScreenTab({super.key});

  @override
  State<BookTrackerDashboardScreenTab> createState() =>
      _BookTrackerDashboardScreenTabState();
}

class _BookTrackerDashboardScreenTabState
    extends State<BookTrackerDashboardScreenTab> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: AppText.body1(text: 'Home')),
    Center(child: AppText.body1(text: 'Discover')),
    Center(child: AppText.body1(text: 'Settings')),
  ];

  final List<NavigationRailDestination> _destinations = [
    NavigationRailDestination(
      icon: const Icon(Icons.home),
      label: AppText.body1(text: 'Home'),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.explore),
      label: AppText.body1(text: 'Discover'),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.settings),
      label: AppText.body1(text: 'Settings'),
    ),
  ];

  Widget _sideNavigationBar() {
    return NavigationRail(
      extended: true,
      groupAlignment: -0.95,
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
      child: Row(
        children: [
          _sideNavigationBar(),
          Expanded(child: _pages[_currentIndex]),
        ],
      ),
    );
  }
}

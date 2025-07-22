import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/config/text_styles.dart';
import 'package:flutter_multi_apps/shared/widgets/base_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme.dart';

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
      icon: const Icon(CupertinoIcons.house_fill),
      label: AppText.body1(text: 'Home'),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.search),
      label: AppText.body1(text: 'Discover'),
      padding: EdgeInsets.symmetric(vertical: 20.r),
    ),
    NavigationRailDestination(
      icon: const Icon(CupertinoIcons.line_horizontal_3),
      label: AppText.body1(text: 'Menu'),
    ),
  ];

  Widget _sideNavigationBar() {
    return NavigationRail(
      minWidth: 130.r,
      indicatorColor: AppColors().primary,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
      ),
      groupAlignment: -0.95,
      labelType: NavigationRailLabelType.all,
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
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
          Expanded(
            child: IndexedStack(index: _currentIndex, children: _pages),
          ),
        ],
      ),
    );
  }
}

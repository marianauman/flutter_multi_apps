import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_app_bar.dart';

class BookTrackerDashboardScreenTab extends StatelessWidget {
  const BookTrackerDashboardScreenTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'BookTrackerHomeScreen'),
      body: Column(
        children: [
          Container(),
        ],
      ),
    );
  }
}
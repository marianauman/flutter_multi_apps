import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/text_styles.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/text_constants.dart';
import '../../model/my_books_tabs_model.dart';

class MyBooksTabs extends StatefulWidget {
  final Function(BookStatus) onTabSelected;
  const MyBooksTabs({super.key, required this.onTabSelected});

  @override
  State<MyBooksTabs> createState() => _MyBooksTabsState();
}

class _MyBooksTabsState extends State<MyBooksTabs> {
  @override
  Widget build(BuildContext context) {
    final List<MyBooksTabsModel> _tabs = [
      MyBooksTabsModel(
        icon: Icons.bookmark,
        title: TextConstants.all,
        color: Colors.red,
        count: 4,
        status: BookStatus.none,
      ),
      MyBooksTabsModel(
        icon: Icons.menu_book,
        title: TextConstants.wantToRead,
        color: Colors.blue,
        count: 1,
        isSelected: true,
        status: BookStatus.wantToRead,
      ),
      MyBooksTabsModel(
        icon: Icons.menu_book,
        title: TextConstants.reading,
        color: Colors.green,
        count: 2,
        status: BookStatus.reading,
      ),
      MyBooksTabsModel(
        icon: Icons.check_circle,
        title: TextConstants.finished,
        color: Colors.orange,
        count: 3,
        status: BookStatus.finished,
      ),
    ];

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          for (int i = 0; i < _tabs.length; i += 2)
            Row(
              children: [
                Expanded(child: _buildTabCard(_tabs[i])),
                if (i + 1 < _tabs.length)
                  Expanded(child: _buildTabCard(_tabs[i + 1])),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTabCard(MyBooksTabsModel tab) {
    return Container(
      decoration: BoxDecoration(
        color: tab.isSelected ? tab.color.customOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            widget.onTabSelected(tab.status);
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tab.icon, color: tab.color, size: 20.sp),
                7.horizontalSpace,
                AppText.body2(
                  text: tab.title,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                ),
                7.horizontalSpace,
                AppText.body2(
                    text: '(${tab.count})',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/text_styles.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/text_constants.dart';
import '../../model/my_books_tabs_model.dart';

class MyBooksTabs extends StatefulWidget {
  const MyBooksTabs({super.key});

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
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 3.5,
        ),
        itemCount: _tabs.length,
        itemBuilder: (context, index) {
          final tab = _tabs[index];
          return _buildTabCard(tab);
        },
      ),
    );
  }

  Widget _buildTabCard(MyBooksTabsModel tab) {
    return Container(
      decoration: BoxDecoration(
        color: tab.isSelected ? tab.color.customOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.customOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // Handle tab tap
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

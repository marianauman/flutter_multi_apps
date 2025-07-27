import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/text_styles.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/text_constants.dart';
import '../../../../../shared/widgets/custom_ink_well.dart';
import '../../model/my_books_tabs_model.dart';
import '../../provider/book_listing_provider.dart';

class MyBooksTabs extends ConsumerStatefulWidget {
  const MyBooksTabs({super.key});

  @override
  ConsumerState<MyBooksTabs> createState() => _MyBooksTabsState();
}

class _MyBooksTabsState extends ConsumerState<MyBooksTabs> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myBooksProvider);

    final List<MyBooksTabsModel> tabs = [
      MyBooksTabsModel(
        icon: Icons.bookmark,
        title: TextConstants.all,
        color: Colors.red,
        count: state.allBooksCount,
        status: BookStatus.none,
        isSelected: state.selectedTab == BookStatus.none,
      ),
      MyBooksTabsModel(
        icon: Icons.menu_book,
        title: TextConstants.wantToRead,
        color: Colors.blue,
        count: state.wantToReadCount,
        isSelected: state.selectedTab == BookStatus.wantToRead,
        status: BookStatus.wantToRead,
      ),
      MyBooksTabsModel(
        icon: Icons.menu_book,
        title: TextConstants.reading,
        color: Colors.green,
        count: state.readingCount,
        isSelected: state.selectedTab == BookStatus.reading,
        status: BookStatus.reading,
      ),
      MyBooksTabsModel(
        icon: Icons.check_circle,
        title: TextConstants.finished,
        color: Colors.orange,
        count: state.finishedCount,
        isSelected: state.selectedTab == BookStatus.finished,
        status: BookStatus.finished,
      ),
    ];

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          for (int i = 0; i < tabs.length; i += 2)
            Row(
              children: [
                Expanded(child: _buildTabCard(tabs[i])),
                if (i + 1 < tabs.length)
                  Expanded(child: _buildTabCard(tabs[i + 1])),
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
        child: CustomInkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            ref.read(myBooksProvider.notifier).selectTab(tab.status);
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

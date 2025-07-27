import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_multi_apps/shared/widgets/base_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/text_constants.dart';
import 'widgets/clear_storage_view.dart';
import 'widgets/set_theme_view.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {

  @override
  Widget build(BuildContext context) {

    return BaseScreen(
      title: TextConstants.menu,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 15.r),
        child: Column(
          children: [
            const SetThemeView(),
            15.customVerticalSpace,
            const ClearStorageView(),
          ],
        ),
      ),
    );
  }
}
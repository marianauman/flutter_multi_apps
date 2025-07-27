import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/routes.dart';
import '../../config/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final List<Widget>? actions;
  final Widget? leading;
  final double? leadingWidth;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  const CustomAppBar({super.key, 
    required this.title,
    this.height = kToolbarHeight,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.leadingWidth,
    this.backgroundColor,
  });

  @override
  Size get preferredSize {
    return Size.fromHeight(
      height + (bottom?.preferredSize.height ?? 0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? modalRoute = ModalRoute.of(context);
    final bool canPop = modalRoute?.canPop ?? false;
    
    return Material(
      elevation: 1,
      child: AppBar(
        title: AppText.title1(
          text: title,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        actions: actions?.map((action) => Padding(
          padding: EdgeInsets.only(right: 12.r),
          child: action,
        )).toList(),
        leading: leading ?? (automaticallyImplyLeading && canPop
          ? IconButton(
                    onPressed: () => NavigationService.pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
          )
          : null),
        leadingWidth: leadingWidth,
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        automaticallyImplyLeading: automaticallyImplyLeading,
        bottom: bottom,
        toolbarHeight: height,
        actionsIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/shared/widgets/custom_app_bar.dart';
import 'package:flutter_multi_apps/shared/widgets/empty_state.dart';

import '../../core/utils/app_utils.dart';
import 'loading_overlay.dart';

class BaseScreen extends StatelessWidget {
  final Widget? child;
  final String? title;
  final bool isLoading;
  final Widget? loaderScreen;
  final bool isEmpty;
  final List<Widget>? actions;
  final Widget? leadingIcon;
  final bool showAppBar;
  final String? emptyStateMessage;
  final Color? backgroundColor;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;
  final PreferredSizeWidget? overrideAppBar;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Color? backbuttonBackgroundColor;
  final EdgeInsets? bodyPadding;
  final Widget? drewaer;
  final Widget? endDrawer;
  final Function(bool)? onEndDrawerChanged;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const BaseScreen({
    super.key,
    this.child,
    this.title,
    this.isLoading = false,
    this.loaderScreen,
    this.isEmpty = false,
    this.actions,
    this.leadingIcon,
    this.showAppBar = true,
    this.emptyStateMessage,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
    this.centerTitle,
    this.overrideAppBar,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.backbuttonBackgroundColor,
    this.bodyPadding,
    this.drewaer,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: Scaffold(
        key: scaffoldKey,
        bottomNavigationBar: bottomNavigationBar,
        drawer: drewaer,
        endDrawer: endDrawer,
        onEndDrawerChanged: onEndDrawerChanged,
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: overrideAppBar ??
            (showAppBar
                ? CustomAppBar(
                    title: title ?? '',
                    actions: actions,
                    leading: leadingIcon,
                    automaticallyImplyLeading: automaticallyImplyLeading,
                    centerTitle: centerTitle != null
                        ? centerTitle!
                        : isTablet(context)
                            ? false
                            : true,
                  )
                : null),
        body: Padding(
          padding: bodyPadding ?? EdgeInsets.zero,
          child: _buildMainContent(),
        ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }

  Widget _buildMainContent() {

    if (isLoading) {
      return loaderScreen ?? Center(child: const CircularProgressIndicator());
    }

    if (isEmpty) {
      return EmptyStateView(message: emptyStateMessage);
    }

    return child ?? const SizedBox.shrink();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/loading_provider.dart';
import '../../core/utils/app_utils.dart';

class LoadingOverlay extends ConsumerWidget {
  final Widget child;
  const LoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider).isLoading;
    final isRefresh = ref.watch(loadingProvider).refreshBarrier;

    return Stack(
      children: [

        child,

        if (isRefresh)...[
          AbsorbPointer(
            child: ModalBarrier(
              dismissible: false,
              color: isDarkMode(context) ? Colors.white12 : Colors.black12,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: RefreshProgressIndicator(
              strokeWidth: 3,
              indicatorMargin: EdgeInsets.only(top: kToolbarHeight + MediaQuery.of(context).padding.top),
              indicatorPadding: EdgeInsets.all(10),
            )
          ),
        ],

        if (isLoading)
          AbsorbPointer(
            child: ModalBarrier(
              dismissible: false,
            ),
          ),
      ],
    );
  }
}

//empty state

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/assets_constants.dart';
import 'lottie_asset.dart';

class EmptyStateView extends StatelessWidget {
  final double? width;
  final double? height;
  final double? fontSize;
  final String? message;

  const EmptyStateView(
      {super.key, this.message, this.width, this.height, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieAsset(
            path: AssetsConstants.emptyState,
            fit: BoxFit.contain,
            width: width ?? 250.r,
            height: height ?? 250.r,
          ),
        ],
      ),
    );
  }
}

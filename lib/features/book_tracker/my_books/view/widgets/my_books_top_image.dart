import 'package:flutter/material.dart';
import 'package:flutter_multi_apps/core/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/theme.dart';
import '../../../../../core/constants/assets_constants.dart';
import '../../../../../shared/widgets/image_asset.dart';

class MyBooksTopImage extends StatelessWidget {
  const MyBooksTopImage({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          height: 270.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors().primary,
                AppColors().primary.customOpacity(0.8),
              ],
            ),
          ),
          child: ImageAsset(
            imagePath: AssetsConstants.booksImage,
            fit: BoxFit.cover,
          ),
        ),
      ]),
    );
  }
}

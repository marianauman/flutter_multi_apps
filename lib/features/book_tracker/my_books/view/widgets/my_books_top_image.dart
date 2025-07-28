import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../shared/widgets/image_asset.dart';

class MyBooksTopImage extends StatelessWidget {
  const MyBooksTopImage({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        SizedBox(
          height: 270.h,
          width: double.infinity,
          child: ImageAsset(
            imagePath: AssetsConstants.booksImage,
            fit: BoxFit.cover,
          ),
        ),
      ]),
    );
  }
}

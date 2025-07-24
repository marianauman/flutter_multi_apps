import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ColorExtension on Color {
  /// Returns a new color with a custom alpha percentage (0 to 1)
  Color customOpacity(double percentage) {
    assert(percentage >= 0 && percentage <= 1, 'Percentage must be between 0 and 1');
    return withAlpha((255 * percentage).toInt());
  }
}

extension SizedBoxExtension on num {
  SizedBox get customVerticalSpace => SizedBox(
    child: ScreenUtil().setVerticalSpacing(this),
  );

  SizedBox get customHorizontalSpace => SizedBox(
    child: ScreenUtil().setHorizontalSpacing(this),
  );
}